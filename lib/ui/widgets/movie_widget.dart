import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/providers.dart';
import 'package:movies/utils/utils.dart';

/// 电影类型枚举，用于区分不同分类的电影
/// 用于生成唯一的 Hero 动画标签
enum MovieType {
  trending,
  popular,
  topRated,
  nowPlaying,
}

/// 电影图片展示组件
/// 支持 Hero 动画过渡效果，点击后跳转到电影详情页
class MovieWidget extends ConsumerStatefulWidget {
  /// 电影数据对象
  final Movie movie;
  /// 点击回调函数
  final OnMovieTap onMovieTap;
  /// 电影类型，用于生成唯一的 Hero 标签
  final MovieType movieType;

  const MovieWidget({
    required this.movie,
    required this.onMovieTap,
    required this.movieType,
    super.key,
  });

  @override
  ConsumerState<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends ConsumerState<MovieWidget> {
  /// 唯一的 Hero 动画标签，由电影地址和类型组合生成
  late String uniqueHeroTag;

  @override
  void initState() {
    super.initState();
    // 根据电影地址和类型生成唯一的 Hero 标签
    uniqueHeroTag = widget.movie.image + widget.movieType.name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 设置当前的 Hero 标签，用于详情页动画
        ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
        widget.onMovieTap(widget.movie.movieId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 100,
          height: 142,
          child: Hero(
            tag: uniqueHeroTag,
            child: CachedNetworkImage(
              imageUrl: widget.movie.image,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitHeight,
              height: 100,
              width: 142,
            ),
          ),
        ),
      ),
    );
  }
}
