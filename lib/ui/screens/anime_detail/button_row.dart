import 'package:flutter/material.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/widgets/text_icon.dart';

/// 收藏按钮点击回调类型
typedef OnFavoriteSelected = void Function();

/// 电影详情页底部按钮行组件
/// 包含收藏、评分、分享三个按钮
/// 收藏按钮支持心跳动画效果
class ButtonRow extends StatefulWidget {
  /// 是否已收藏
  final bool favoriteSelected;
  /// 收藏按钮点击回调
  final OnFavoriteSelected onFavoriteSelected;

  const ButtonRow({
    super.key,
    required this.favoriteSelected,
    required this.onFavoriteSelected,
  });

  @override
  State<ButtonRow> createState() => _ButtonRowState();
}

/// ButtonRow 的状态类
/// 使用 TickerProviderStateMixin 支持多个动画控制器
class _ButtonRowState extends State<ButtonRow> with TickerProviderStateMixin {
  /// 尺寸动画控制器，控制心跳动画的大小变化
  late AnimationController _sizeController;
  /// 尺寸动画，从原始大小到放大 1.5 倍
  late Animation<double> _sizeAnimation;

  /// 颜色动画控制器，控制心跳动画的颜色变化
  late AnimationController _colorController;
  /// 颜色动画，从白色到红色
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    // 创建尺寸控制器，1秒动画，重复播放（先正向再反向）
    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // 创建尺寸动画，从 1.0 到 1.5 的缩放效果
    _sizeAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(
      CurvedAnimation(parent: _sizeController, curve: Curves.easeInOut),
    );

    // 创建颜色控制器，1秒动画，重复播放
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // 创建颜色动画，从白色到红色
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.red,
    ).animate(
      CurvedAnimation(parent: _colorController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    // 释放动画控制器资源
    _sizeController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 0, bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextIcon(
            text: Text(
              'Favorite',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            icon: IconButton(
              onPressed: () {
                widget.onFavoriteSelected();
              },
              // 如果已收藏，显示心跳动画；否则显示普通心形图标
              icon: widget.favoriteSelected
                  ? AnimatedBuilder(
                      animation: Listenable.merge([
                        _sizeController,
                        _colorController,
                      ]),
                      builder: (context, child) {
                        return Icon(
                          Icons.favorite_outlined,
                          size: 21 * _sizeAnimation.value,
                          color: _colorAnimation.value,
                        );
                      },
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
            ),
          ),
          addHorizontalSpace(32),
          TextIcon(
            text: Text(
              'Rate',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
          addHorizontalSpace(32),
          TextIcon(
            text: Text(
              'Share',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.ios_share,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
