import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/providers.dart';
import 'package:movies/utils/utils.dart';

/// 年份格式化器
final yearFormat = DateFormat('yyyy');

/// 动漫详情页顶部封面图组件
/// 网络图片 + 底部渐进色，标题叠在图上；下方衔接 AnimeOverview 信息面板
class DetailImage extends ConsumerStatefulWidget {
  /// 动漫详情数据
  final AnimeDetails details;

  /// 封面图地址（用于详情页顶部）
  final String? bannerImage;

  /// 图片高度
  final double height;

  const DetailImage({required this.details, this.bannerImage, this.height = 280, super.key});

  @override
  ConsumerState<DetailImage> createState() => _DetailImageState();
}

/// DetailImage 的状态类
/// 使用 SingleTickerProviderStateMixin 提供动画所需的 Ticker
class _DetailImageState extends ConsumerState<DetailImage>
    with SingleTickerProviderStateMixin {
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
    final imageUrl = widget.details.image;
    final imageHeight = widget.height;
    // 标题停在渐变加深区上方，与下方 AnimeOverview 衔接
    final titleBottom = imageHeight * 0.12 + 12;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: SizedBox(
        height: imageHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: heroTag,
                child: FadeTransition(
                  opacity: _animation,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    height: imageHeight,
                    width: screenWidth,
                  ),
                ),
              ),
            ),
            // 渐进色：上透明 → 下加深，衔接 AnimeOverview 深色面板
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0x002B2B2B),
                      const Color(0xB32B2B2B),
                      const Color(0xFF2B2B2B),
                    ],
                    stops: const [0.0, 0.4, 0.75, 1.0],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24.0, bottom: titleBottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.details.displayTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    addVerticalSpace(4),
                    Text(
                      widget.details.year != null
                          ? yearFormat.format(DateTime(widget.details.year!))
                          : '',
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