import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/providers.dart';

/// 动漫详情页左侧完整海报
/// 展示完整封面 detail.image（主视觉），不做标题叠字；元信息放在海报下方
/// 背景渐进色横幅由 DetailBanner 负责（图源 bannerImage）
class DetailImage extends ConsumerStatefulWidget {
  /// 动漫详情数据
  final AnimeDetails details;

  /// 海报宽度
  final double width;

  const DetailImage({
    required this.details,
    this.width = 240,
    super.key,
  });

  @override
  ConsumerState<DetailImage> createState() => _DetailImageState();
}

class _DetailImageState extends ConsumerState<DetailImage>
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
    final heroTag = ref.watch(heroTagProvider);
    final imageUrl = widget.details.image;

    // 参考页海报约 280×490，约 4:7；完整封面
    return AspectRatio(
      aspectRatio: 280 / 490,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: ColoredBox(
          color: const Color(0xFF232323),
          child: Hero(
            tag: heroTag,
            child: FadeTransition(
              opacity: _animation,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) => const ColoredBox(
                  color: Color(0xFF232323),
                ),
                errorWidget: (context, url, error) => const ColoredBox(
                  color: Color(0xFF232323),
                  child: Center(
                    child: Icon(Icons.broken_image, color: Color(0xFF666666)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}