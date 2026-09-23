import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/utils/utils.dart';

/// 年份格式化器
final yearFormat = DateFormat('yyyy');

/// 轮播图自动播放延迟时间（毫秒）
const delayTime = 1000 * 10;
/// 轮播图动画过渡时间（毫秒）
const animationTime = 1000;

/// 首页轮播图组件
/// 展示动漫封面图片，支持 Hero 动画过渡效果
/// 显示标题、年份和简介
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
          String uniqueHeroTag = '${currentAnime.image}swiper';

          return GestureDetector(
            onTap: () {
              ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
              onAnimeTap(currentAnime.animeId);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  // 背景图片
                  Align(
                    alignment: Alignment.topCenter,
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
                  ),
                  // 底部信息叠加层
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 标题
                          Text(
                            currentAnime.title ?? '',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          addVerticalSpace(4),
                          // 年份
                          currentAnime.aired != null
                              ? Text(
                                  yearFormat.format(currentAnime.aired!),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : const SizedBox.shrink(),
                          addVerticalSpace(4),
                          // 简介
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                            child: AutoSizeText(
                              currentAnime.synopsis ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
