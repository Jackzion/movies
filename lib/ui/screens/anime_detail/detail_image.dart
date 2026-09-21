import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/utils/utils.dart';

/// 动漫详情页顶部封面图组件
/// 支持网络图片加载，带有入场动画和 Hero 过渡效果
class DetailImage extends ConsumerStatefulWidget {
  /// 动漫封面图片的网络地址
  final String animeUrl;
  const DetailImage({required this.animeUrl, super.key});

  @override
  ConsumerState<DetailImage> createState() => _DetailImageState();
}

/// DetailImage 的状态类
/// 使用 SingleTickerProviderStateMixin 提供动画所需的 Ticker
class _DetailImageState extends ConsumerState<DetailImage> with SingleTickerProviderStateMixin {
  /// 动画控制器，控制图片入场动画
  /// 动画时长为 2 秒
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  /// 曲线动画，为控制器添加缓动效果
  /// 使用 easeIn 曲线，使动画开始时较慢，结束时较快
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    // 组件初始化时立即启动动画
    _controller.forward();
  }

  @override
  void dispose() {
    // 释放动画控制器资源，防止内存泄漏
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 从 provider 获取当前的 Hero 动画标签
    final heroTag = ref.watch(heroTagProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: heroTag,
                child: FadeTransition(
                  opacity: _animation,
                  child: CachedNetworkImage(
                    imageUrl: widget.animeUrl,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: screenWidth,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dune',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    addVerticalSpace(4),
                    Text(
                      '2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
