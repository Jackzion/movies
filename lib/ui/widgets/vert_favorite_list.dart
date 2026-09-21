import 'package:flutter/material.dart';
import 'package:movies/data/models/favorite.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/widgets/favorite_row.dart';

/// 纵向收藏动漫列表组件
/// 展示收藏的动漫列表，支持点击和收藏操作
class VerticalFavoriteList extends StatelessWidget {
  /// 收藏动漫列表
  final List<Favorite> favorites;
  /// 动漫视图模型
  final AnimeViewModel animeViewModel;
  /// 点击回调函数
  final OnAnimeTap onAnimeTap;
  /// 收藏按钮点击回调
  final OnFavoriteResultsTap onFavoritesTap;

  const VerticalFavoriteList({
    super.key,
    required this.favorites,
    required this.animeViewModel,
    required this.onAnimeTap,
    required this.onFavoritesTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return FavoriteRow(
            favorite: favorites[index],
            animeViewModel: animeViewModel,
            onAnimeTap: (id) {
              onAnimeTap(id);
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
