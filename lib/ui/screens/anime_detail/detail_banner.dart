import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/utils/utils.dart';

/// 动漫详情页顶部渐进色背景横幅
/// 图源优先 AniList bannerImage（按 animeId 补充），缺失时回退条目封面
class DetailBanner extends ConsumerStatefulWidget {
  /// 动漫详情数据
  final AnimeDetails details;

  /// 对应 animeId 的 bannerImage（AniList 补充数据）
  final String? bannerImage;

  /// 横幅高度
  final double height;

  const DetailBanner({
    required this.details,
    this.bannerImage,
    this.height = 280,
    super.key,
  });

  @override
  ConsumerState<DetailBanner> createState() => _DetailBannerState();
}

class _DetailBannerState extends ConsumerState<DetailBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final details = widget.details;
    // 背景图：优先 animeId 对应 bannerImage，回退 detail.image
    final imageUrl = (widget.bannerImage != null && widget.bannerImage!.isNotEmpty)
        ? widget.bannerImage!
        : details.image;
    final imageHeight = widget.height;
    final titleBottom = imageHeight * 0.12 + 12;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: SizedBox(
        height: imageHeight,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FadeTransition(
                opacity: _animation,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  height: imageHeight,
                  width: double.infinity,
                  placeholder: (context, url) => const ColoredBox(
                    color: Color(0xFF232323),
                  ),
                  errorWidget: (context, url, error) => const ColoredBox(
                    color: Color(0xFF232323),
                  ),
                ),
              ),
            ),
            // 渐进色：上透明 → 下加深，衔接深色面板
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
                      details.displayTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    addVerticalSpace(4),
                    Text(
                      details.year != null ? '${details.year}' : '',
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