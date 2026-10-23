import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/ui/search/global_search_controller.dart';
import 'package:movies/ui/theme/theme.dart';

/// 全屏幕布 + 居中超大搜索框（全局搜索 UI 层）
///
/// 布局：半透明黑幕布（点击关闭）+ 居中 Material 卡片内的大号 [TextField]。
/// 用 Overlay / Stack 浮在业务页之上，**不** push 路由，避免：
/// - 与 auto_route 返回栈冲突
/// - 触发 AnimeDetail 等页无谓 rebuild（参见窗口缩放重载修复）
class GlobalSearchOverlay extends StatelessWidget {
  const GlobalSearchOverlay({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onEscape,
  });

  /// 开/关、文本与焦点
  final GlobalSearchController controller;

  /// 回车提交回调；传入「切 Genre + searchTextProvider」
  /// 为空时仅关闭 Overlay
  final ValueChanged<String>? onSubmitted;

  /// 输入框内按 Esc 时回调（默认可只 close；Scope 会再抢回根焦点）
  final VoidCallback? onEscape;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // 幕布：吃掉下层点击，点空白关闭
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: controller.close,
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.55),
              ),
            ),
          ),
          // 居中超大输入框（限制最大宽，窗口很宽时也不拉变形）
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Material(
                  color: searchBarBackground,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    // 焦点在大输入框时，Esc 先到这里的 Focus；
                    // 根 Scope 的 onKeyEvent 不一定能抢到，故本层也处理一次
                    child: Focus(
                      onKeyEvent: (node, event) {
                        if (event is KeyDownEvent &&
                            event.logicalKey ==
                                LogicalKeyboardKey.escape) {
                          if (onEscape != null) {
                            onEscape!();
                          } else {
                            controller.close();
                          }
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: TextField(
                        controller: controller.textController,
                        focusNode: controller.fieldFocusNode,
                        autofocus: true,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                        cursorColor: accentAmber,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '搜索番剧…',
                          hintStyle: const TextStyle(
                            color: posterBorder,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: posterBorder,
                            size: 32,
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          if (onSubmitted != null) {
                            onSubmitted!(value);
                          } else {
                            // Phase 1：未接搜索链路时先关闭
                            controller.close();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
