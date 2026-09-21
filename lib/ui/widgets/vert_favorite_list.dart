import 'package:flutter/material.dart';
import 'package:movies/data/models/favorite.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/ui/widgets/favorite_row.dart';

/// 纵向收藏电影列表组件
/// 展示收藏的电影列表，支持点击和收藏操作
class VerticalFavoriteList extends StatelessWidget {
  /// 收藏电影列表
  final List<Favorite> favorites;
  /// 电影视图模型
  final MovieViewModel movieViewModel;
  /// 点击回调函数
  final OnMovieTap onMovieTap;
  /// 收藏按钮点击回调
  final OnFavoriteResultsTap onFavoritesTap;

  const VerticalFavoriteList({
    super.key,
    required this.favorites,
    required this.movieViewModel,
    required this.onMovieTap,
    required this.onFavoritesTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return FavoriteRow(
            favorite: favorites[index],
            movieViewModel: movieViewModel,
            onMovieTap: (id) {
              onMovieTap(id);
            },
            onFavoritesTap: (favorite) {
              onFavoritesTap(favorite);
            },
          );
        },
        childCount: favorites.length,
      ),
    );
  }
}
