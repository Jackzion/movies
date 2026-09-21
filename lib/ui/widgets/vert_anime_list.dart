import 'package:flutter/material.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/widgets/anime_row.dart';

/// 纵向动漫列表组件
/// 展示动漫列表，支持 Hero 动画过渡效果
class VerticalAnimeList extends StatelessWidget {
  /// 动漫列表数据
  final List<Anime> animes;
  /// 点击回调函数
  final OnAnimeTap onAnimeTap;

  const VerticalAnimeList({
    super.key,
    required this.animes,
    required this.onAnimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          // 使用 AnimeRow 组件展示动漫信息
          return AnimeRow(
            anime: animes[index],
            onAnimeTap: onAnimeTap,
          );
        },
        childCount: animes.length,
      ),
    );
  }
}
