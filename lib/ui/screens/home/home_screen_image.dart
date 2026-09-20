import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/utils/utils.dart';

/// 轮播图自动播放延迟时间（毫秒）
const delayTime = 1000 * 10;
/// 轮播图动画过渡时间（毫秒）
const animationTime = 1000;

/// 首页轮播图组件
/// 展示电影封面图片，支持 Hero 动画过渡效果
class HomeScreenImage extends StatelessWidget {
  /// 电影视图模型
  final MovieViewModel movieViewModel;
  /// 点击回调函数
  final OnMovieTap onMovieTap;

  const HomeScreenImage({
    required this.movieViewModel,
    required this.onMovieTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 32;

    return SizedBox(
      height: 374,
      child: Swiper(
        itemCount: movieViewModel.nowPlayingMovies.length,
        itemBuilder: (BuildContext context, int index) {
          final currentMovie = movieViewModel.nowPlayingMovies[index];
          // 生成唯一的 Hero 动画标签
          String uniqueHeroTag = '${currentMovie.image}swiper';

          return GestureDetector(
            onTap: () {
              // 设置当前的 Hero 标签，用于详情页动画
              ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
              onMovieTap(currentMovie.movieId);
            },
            child: Hero(
              tag: uniqueHeroTag,
              child: CachedNetworkImage(
                imageUrl: currentMovie.image,
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
