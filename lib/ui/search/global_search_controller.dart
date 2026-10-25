import 'package:flutter/widgets.dart';

/// 全局搜索唤起层的状态容器。
///
/// 职责：
/// - 维护 Overlay 开关（不走路由，避免和 auto_route 返回栈抢焦点）
/// - 持有大输入框的 [TextEditingController] / [FocusNode]
/// - 支持「首字符 seed」：唤起时把触发键写入框内（Spotlight 行为）
/// - **中文 IME**：输入框常驻并保持焦点，拼音组合/已提交文本出现时自动展开
/// - 本地删除后短窗内修补平台回传的过期文本（Windows backspace 后打字复原）
class GlobalSearchController extends ChangeNotifier {
  /// Overlay 是否已打开
  bool _open = false;

  bool get isOpen => _open;

  /// 超大搜索框内容
  final TextEditingController textController = _GuardedTextEditingController();

  /// 超大搜索框焦点：常驻，关闭后也不丢，否则中文 IME 没有 TextInput 客户端
  final FocusNode fieldFocusNode = FocusNode();

  GlobalSearchController() {
    textController.addListener(_onFieldChanged);
  }

  /// 拼音预编辑或已上屏文字出现 → 展开搜索层。
  ///
  /// 中文 IME 只向「已聚焦的 TextField」投递组合区（composing）。
  /// 关闭态下输入框仍聚焦，拼音一进来这里就 open，实现「先出拼音再出搜索框」。
  void _onFieldChanged() {
    if (_open) return;
    final value = textController.value;
    final composing = value.composing;
    final isComposing = composing.isValid && !composing.isCollapsed;
    if (isComposing || value.text.isNotEmpty) {
      open();
    }
  }

  /// 确保大输入框持有焦点（中文 IME 的 TextInput 客户端）。
  ///
  /// 和根 FocusScope.autofocus、业务页按钮抢焦点时容易丢焦点；
  /// 丢焦点后 Windows 中文 IME 根本不会把拼音投给 Flutter。
  void ensureFieldFocused() {
    void grab() {
      if (!fieldFocusNode.hasFocus) {
        fieldFocusNode.requestFocus();
      }
      // 立刻结算，下一帧 IME 才能找到 client
      FocusManager.instance.applyFocusChangesIfNeeded();
    }

    grab();
    WidgetsBinding.instance.addPostFrameCallback((_) => grab());
  }

  /// 唤起搜索层。
  ///
  /// [seed] 为触发唤起的首字符（可打印键 / 英文）；中文拼音不要 seed，
  /// 交给 IME 做预编辑。为空则打开空框（如 Ctrl+K、拼音）。
  void open({String? seed}) {
    if (_open) {
      // 已打开时 seed 只在框仍为空时写入，避免覆盖拼音组合
      if (seed != null &&
          seed.isNotEmpty &&
          textController.text.isEmpty &&
          !isComposing) {
        textController.text = seed;
        textController.selection = TextSelection.collapsed(offset: seed.length);
      }
      ensureFieldFocused();
      return;
    }
    _open = true;
    if (seed != null && seed.isNotEmpty) {
      textController.text = seed;
      textController.selection = TextSelection.collapsed(offset: seed.length);
    }
    notifyListeners();
    ensureFieldFocused();
  }

  /// 关闭搜索层并清空草稿。
  ///
  /// **不** unfocus 输入框：中文 IME 需要它作为 TextInput 客户端；
  /// 清空后焦点仍留在框上，下一次拼音从第一键就能进来。
  void close() {
    if (!_open) return;
    _open = false;
    textController.clear();
    // 丢弃可能残留的组合区
    textController.value = TextEditingValue.empty;
    notifyListeners();
    // 焦点必须留在搜索框：否则下一次中文 IME 无 client，拼音进不来
    ensureFieldFocused();
  }

  /// IME 组合中（拼音候选等）：此时 backspace 交给输入法，不能本地删。
  bool get isComposing {
    final composing = textController.value.composing;
    return composing.isValid && !composing.isCollapsed;
  }

  _GuardedTextEditingController get _ctrl =>
      textController as _GuardedTextEditingController;

  /// 本地 backspace：删选区或光标前一字符。返回是否发生了删除。
  bool applyBackspace() {
    final value = _ctrl.value;
    final text = value.text;
    final selection = value.selection;
    if (text.isEmpty) return false;

    if (selection.isValid && !selection.isCollapsed) {
      final start = selection.start;
      final end = selection.end;
      _ctrl.applyLocalEdit(
        TextEditingValue(
          text: text.replaceRange(start, end, ''),
          selection: TextSelection.collapsed(offset: start),
        ),
        preDeleteText: text,
      );
      return true;
    }

    final offset = selection.isValid ? selection.start : text.length;
    if (offset <= 0) return false;

    _ctrl.applyLocalEdit(
      TextEditingValue(
        text: text.substring(0, offset - 1) + text.substring(offset),
        selection: TextSelection.collapsed(offset: offset - 1),
      ),
      preDeleteText: text,
    );
    return true;
  }

  /// 本地向前删除（Delete 键）。
  bool applyForwardDelete() {
    final value = _ctrl.value;
    final text = value.text;
    final selection = value.selection;
    if (text.isEmpty) return false;

    if (selection.isValid && !selection.isCollapsed) {
      final start = selection.start;
      final end = selection.end;
      _ctrl.applyLocalEdit(
        TextEditingValue(
          text: text.replaceRange(start, end, ''),
          selection: TextSelection.collapsed(offset: start),
        ),
        preDeleteText: text,
      );
      return true;
    }

    final offset = selection.isValid ? selection.start : 0;
    if (offset >= text.length) return false;

    _ctrl.applyLocalEdit(
      TextEditingValue(
        text: text.substring(0, offset) + text.substring(offset + 1),
        selection: TextSelection.collapsed(offset: offset),
      ),
      preDeleteText: text,
    );
    return true;
  }

  @override
  void dispose() {
    textController.removeListener(_onFieldChanged);
    textController.dispose();
    fieldFocusNode.dispose();
    super.dispose();
  }
}

/// 修补 Windows 文本通道的过期回写。
///
/// 场景：本地 backspace 把 `hello` 删成 `hell` 后，平台侧仍缓存旧快照，
/// 继续打字时回传 `hello` + 新字符，把删掉的字「复活」。
///
/// 本地删除时登记 preDelete 全文（连续删多字会留下中间态）；
/// 短窗内若收到 `startsWith(preDelete)` 的非 IME 更新，视为
/// 「旧快照 + 平台追加的后缀」，改写为「本地文本 + 后缀」。
/// 匹配时优先取**最长**的 preDelete —— 平台往往停留在最早的完整快照上。
class _GuardedTextEditingController extends TextEditingController {
  /// 删除前全文快照，按登记顺序（最早删除前在前）。
  final List<String> _recentPreDeletes = <String>[];

  DateTime _windowAt = DateTime.fromMillisecondsSinceEpoch(0);

  /// 删除后允许修补过期回传的时间窗。再长会误伤用户手动打回同样内容。
  static const _staleWindow = Duration(milliseconds: 600);

  /// true = 下一次 set 是我们自己的本地删改，不能清候选。
  bool _applyingLocalEdit = false;

  void applyLocalEdit(
    TextEditingValue newValue, {
    required String preDeleteText,
  }) {
    final now = DateTime.now();
    if (now.difference(_windowAt) > _staleWindow) {
      _recentPreDeletes.clear();
    }
    _windowAt = now;
    if (!_recentPreDeletes.contains(preDeleteText)) {
      _recentPreDeletes.add(preDeleteText);
    }
    _applyingLocalEdit = true;
    value = newValue;
  }

  @override
  set value(TextEditingValue newValue) {
    if (_applyingLocalEdit) {
      _applyingLocalEdit = false;
      super.value = newValue;
      return;
    }

    // IME 组合交给输入法，不做修补
    final composing = newValue.composing;
    if (composing.isValid && !composing.isCollapsed) {
      _recentPreDeletes.clear();
      super.value = newValue;
      return;
    }

    final now = DateTime.now();
    if (now.difference(_windowAt) > _staleWindow) {
      _recentPreDeletes.clear();
    }

    if (_recentPreDeletes.isNotEmpty && newValue.text != text) {
      // 候选：pre 是「本地文本 + 被删段」且过期值以 pre 开头
      String? bestPre;
      for (final pre in _recentPreDeletes) {
        if (pre.startsWith(text) && newValue.text.startsWith(pre)) {
          if (bestPre == null || pre.length > bestPre.length) {
            bestPre = pre;
          }
        }
      }
      if (bestPre != null) {
        final suffix = newValue.text.substring(bestPre.length);
        final repaired = text + suffix;
        _recentPreDeletes.clear();
        super.value = TextEditingValue(
          text: repaired,
          selection: TextSelection.collapsed(offset: repaired.length),
        );
        return;
      }
    }

    _recentPreDeletes.clear();
    super.value = newValue;
  }
}
