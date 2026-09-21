import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/utils/utils.dart';

/// 轮播图自动播放延迟时间（毫秒）
const delayTime = 1000 * 10;
/// 轮播图动画过渡时间（毫秒）
const animationTime = 1000;

/// 首页轮播图组件
/// 展示动漫封面图片，支持 Hero 动画过渡效果
class HomeScreenImage extends ConsumerWidget {
  /// 动漫视图模型
  final AnimeViewModel animeViewModel;
  /// 点击回调函数
  final OnAnimeTap onAnimeTap;

  const HomeScreenImage({
    required this.animeViewModel,
    required this.onAnimeTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width - 32;

    return SizedBox(
      height: 374,
      child: Swiper(
        itemCount: animeViewModel.nowPlayingAnimes.length,
        itemBuilder: (BuildContext context, int index) {
          final currentAnime = animeViewModel.nowPlayingAnimes[index];
          // 生成唯一的 Hero 动画标签
          String uniqueHeroTag = '${currentAnime.image}swiper';

          return GestureDetector(
            onTap: () {
              // 设置当前的 Hero 标签，用于详情页动画
              ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
              onAnimeTap(currentAnime.animeId);
            },
            child: Hero(
              tag: uniqueHeroTag,
              child: CachedNetworkImage(
                imageUrl: currentAnime.image,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitHeight,
                height: 374,
                width: screenWidth,
              ),
            ),
          );
        },
        autoplayDelay: delayTime,
        duration: animationTime,
        itemWidth: screenWidth,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}
