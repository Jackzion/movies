import 'package:flutter/material.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/widgets/movie_row.dart';

/// 纵向电影列表组件
/// 展示电影列表，支持 Hero 动画过渡效果
class VerticalMovieList extends StatelessWidget {
  /// 电影列表数据
  final List<Movie> movies;
  /// 点击回调函数
  final OnMovieTap onMovieTap;

  const VerticalMovieList({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          // 使用 MovieRow 组件展示电影信息
          return MovieRow(
            movie: movies[index],
            onMovieTap: onMovieTap,
          );
        },
        childCount: movies.length,
      ),
    );
  }
}
