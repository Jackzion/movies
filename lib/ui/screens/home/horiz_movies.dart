import 'package:flutter/material.dart';
import 'package:movies/ui/widgets/movie_widget.dart';
import 'package:movies/utils/utils.dart';

/// 横向滚动的电影列表组件
/// 支持不同电影类型的展示，点击后跳转到详情页
class HorizontalMovies extends StatelessWidget {
  /// 电影列表数据
  final List<String> movies;
  /// 点击回调函数
  final OnMovieTap onMovieTap;
  /// 电影类型，用于生成唯一的 Hero 标签
  final MovieType movieType;

  const HorizontalMovies({
    required this.onMovieTap,
    required this.movies,
    required this.movieType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          // 使用 MovieWidget 组件展示电影图片
          return MovieWidget(
            movieId: index,
            movieUrl: movies[index],
            onMovieTap: onMovieTap,
            movieType: movieType,
          );
        },
      ),
    );
  }
}
