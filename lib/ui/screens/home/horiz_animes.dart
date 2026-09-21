import 'package:flutter/material.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/ui/widgets/anime_widget.dart';
import 'package:movies/utils/utils.dart';

/// 横向滚动的动漫列表组件
/// 支持不同动漫类型的展示，点击后跳转到详情页
class HorizontalAnimes extends StatelessWidget {
  /// 动漫列表数据
  final List<Anime> animes;
  /// 点击回调函数
  final OnAnimeTap onAnimeTap;
  /// 动漫类型，用于生成唯一的 Hero 标签
  final AnimeType animeType;

  const HorizontalAnimes({
    required this.onAnimeTap,
    required this.animes,
    required this.animeType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: animes.length,
        itemBuilder: (context, index) {
          // 使用 AnimeWidget 组件展示动漫图片
          return AnimeWidget(
            anime: animes[index],
            onAnimeTap: onAnimeTap,
            animeType: animeType,
          );
        },
      ),
    );
  }
}
