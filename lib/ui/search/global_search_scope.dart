import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/ui/search/global_search_controller.dart';
import 'package:movies/ui/search/global_search_overlay.dart';

/// 全局搜索的键盘路由与 Overlay 挂载点（应放在 App 根，如 MaterialApp.builder）。
///
/// 键盘策略（Idle = Overlay 未打开）：
/// | 条件 | 行为 |
/// |------|------|
/// | Overlay 打开且 Esc | 关闭 Overlay |
/// | Overlay 打开且其它键 | ignored（交给大输入框 / IME） |
/// | Ctrl/Cmd + K | 强制唤起（不受「输入框中」限制） |
/// | 焦点在 EditableText | ignored（业务搜索框/对话框打字不误触） |
/// | 可打印字符 | 唤起并写入首字符 |
///
/// 详见 docs/全局搜索-Phase1-唤起层.md。
class GlobalSearchScope extends StatefulWidget {
  const GlobalSearchScope({super.key, required this.child});

  /// 原 App 内容（路由子树）
  final Widget child;

  @override
  State<GlobalSearchScope> createState() => _GlobalSearchScopeState();
}

class _GlobalSearchScopeState extends State<GlobalSearchScope> {
  final GlobalSearchController _controller = GlobalSearchController();

  /// 根「键盘入口」节点：Overlay 关掉后必须抢回焦点，
  /// 否则 primaryFocus 变成 null，后续 KeyDown 进不到 [_onKey]，表现为「关一次就再也呼不出来」。
  final FocusNode _rootFocusNode = FocusNode(debugLabel: 'GlobalSearchRoot');

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _rootFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_controller.isOpen || !mounted) return;
    // 关闭后下一帧再要焦点：等 Overlay 从树上移除、大输入框 unfocus 生效
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _rootFocusNode.requestFocus();
      }
    });
  }

  /// 焦点是否落在业务输入框内
  ///
  /// TextField / TextFormField 内部焦点节点对应 [EditableText]；
  /// 只查 [EditableText] 即可覆盖所有标准输入框，无需枚举业务 FocusNode。
  bool get _isTypingElsewhere {
    final ctx = FocusManager.instance.primaryFocus?.context;
    if (ctx == null) return false;
    if (ctx.widget is EditableText) return true;
    return ctx.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  /// 是否为控制字符（换行、Esc 等），不能当作「可打印唤起键」
  bool _isControlChar(String ch) {
    final code = ch.codeUnitAt(0);
    return code < 0x20 || code == 0x7f;
  }

  /// 全局键盘事件处理
  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    // —— Overlay 已打开：只处理 Esc，其余交给输入框 ——
    if (_controller.isOpen) {
      if (event is KeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.escape) {
        _controller.close();
        // listener 里会 requestFocus 回根节点
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }

    // 仅 KeyDown；KeyUp/KeyRepeat 不重复唤起
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    // —— Ctrl/Cmd+K：强制唤起（输入框聚焦时也可用）——
    final isCtrl = HardwareKeyboard.instance.isControlPressed ||
        HardwareKeyboard.instance.isMetaPressed;
    if (isCtrl && event.logicalKey == LogicalKeyboardKey.keyK) {
      _controller.open();
      return KeyEventResult.handled;
    }

    // —— 业务输入框中：让系统处理，不抢键 ——
    if (_isTypingElsewhere) return KeyEventResult.ignored;

    // —— 可打印字符：唤起并带上首字符 ——
    final ch = event.character;
    if (ch != null && ch.isNotEmpty && !_isControlChar(ch)) {
      _controller.open(seed: ch);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      // 显式挂载自持节点，关闭后可强制 requestFocus 回来
      focusNode: _rootFocusNode,
      // 根节点默认持焦，否则收不到全局 KeyEvent
      autofocus: true,
      // 监听全局键盘事件
      onKeyEvent: _onKey,
      child: Stack(
        children: [
          widget.child,
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              if (!_controller.isOpen) return const SizedBox.shrink();
              return GlobalSearchOverlay(
                controller: _controller,
                // 输入框内 Esc：部分场景焦点在 TextField，根 Focus 未必先收到
                onEscape: _controller.close,
              );
              // Phase 2：onSubmitted: (q) => _submitToGenre(q)
            },
          ),
        ],
      ),
    );
  }
}
