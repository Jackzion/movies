import 'package:flutter/widgets.dart';

/// 全局搜索唤起层的状态容器。
///
/// 职责：
/// - 维护 Overlay 开关（不走路由，避免和 auto_route 返回栈抢焦点）
/// - 持有大输入框的 [TextEditingController] / [FocusNode]
/// - 支持「首字符 seed」：唤起时把触发键写入框内（Spotlight 行为）
///
/// 由 [GlobalSearchOverlay.onSubmitted] 消费文本并跳转 Genre
class GlobalSearchController extends ChangeNotifier {
  /// Overlay 是否已打开
  bool _open = false;

  bool get isOpen => _open;

  /// 超大搜索框内容
  final TextEditingController textController = TextEditingController();

  /// 超大搜索框焦点：open 后必须 requestFocus，否则后续按键进不来
  final FocusNode fieldFocusNode = FocusNode();

  /// 唤起搜索层。
  ///
  /// [seed] 为触发唤起的首字符（可打印键）；为空则打开空框（如 Ctrl+K）。
  void open({String? seed}) {
    if (_open) return;
    _open = true;
    if (seed != null && seed.isNotEmpty) {
      textController.text = seed;
      // 光标放到末尾，继续打字追加而不是覆盖
      textController.selection = TextSelection.collapsed(offset: seed.length);
    }
    // notifyListeners() 通知依赖者更新
    notifyListeners();
    // Overlay 尚未完成布局时 requestFocus 会失败，放到下一帧
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fieldFocusNode.requestFocus();
    });
  }

  /// 关闭搜索层并清空草稿（下次唤起从空或新 seed 开始）。
  void close() {
    if (!_open) return;
    _open = false;
    textController.clear();
    fieldFocusNode.unfocus();
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    fieldFocusNode.dispose();
    super.dispose();
  }
}
