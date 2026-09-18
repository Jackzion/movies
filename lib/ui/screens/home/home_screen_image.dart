import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/utils/utils.dart';

/// 轮播图自动播放延迟时间（毫秒）
const delayTime = 1000 * 10;
/// 轮播图动画过渡时间（毫秒）
const animationTime = 1000;

/// 首页轮播图组件
/// 展示电影封面图片，支持 Hero 动画过渡效果
class HomeScreenImage extends ConsumerWidget {
  /// 点击回调函数
  final OnMovieTap onMovieTap;
  const HomeScreenImage({super.key, required this.onMovieTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 从 provider 获取电影图片列表
    final movies = ref.watch(movieImagesProvider);
    final screenWidth = MediaQuery.of(context).size.width - 32;

    return SizedBox(
      height: 374,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // 设置当前的 Hero 标签，用于详情页动画
              // 标签格式：电影地址 + 'swiper'
              ref.read(heroTagProvider.notifier).state =
                  movies[index] + 'swiper';
              onMovieTap(index);
            },
            child: Hero(
              tag: movies[index] + 'swiper',
              child: CachedNetworkImage(
                imageUrl: movies[index],
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
        itemCount: movies.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}
