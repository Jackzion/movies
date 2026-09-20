import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/providers.dart';
import 'package:movies/utils/utils.dart';

/// 电影行展示组件
/// 支持 Hero 动画过渡效果，点击后跳转到电影详情页
class MovieRow extends ConsumerWidget {
  /// 电影数据对象
  final Movie movie;
  /// 点击回调函数
  final OnMovieTap onMovieTap;

  const MovieRow({
    required this.movie,
    required this.onMovieTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 唯一的 Hero 动画标签，由电影地址和 'MovieRow' 组合生成
    String uniqueHeroTag = movie.image + 'MovieRow';

    if (movie.image.isNotEmpty) {
      return GestureDetector(
        onTap: () {
          // 设置当前的 Hero 标签，用于详情页动画
          ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
          onMovieTap(movie.movieId);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 140,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                addHorizontalSpace(16),
                SizedBox(
                  height: 142,
                  width: 100,
                  child: Hero(
                    tag: uniqueHeroTag,
                    child: CachedNetworkImage(
                      imageUrl: movie.image,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      height: 142,
                      width: 100,
                    ),
                  ),
                ),
                addHorizontalSpace(16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      movie.title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    addVerticalSpace(4),
                    Text(
                      movie.releaseDate.year.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    addVerticalSpace(4),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
