import 'package:flutter/material.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/widgets/anime_widget.dart';
import 'package:movies/utils/utils.dart';

/// 动漫卡片网格组件
/// 每屏默认展示 [itemCount] 张横幅卡片，按窗口宽度自适应列数并自动分行
class HorizontalAnimes extends StatelessWidget {
  /// 动漫列表数据
  final List<Anime> animes;

  /// 动漫视图模型（收藏状态与横幅补充数据）
  final AnimeViewModel animeViewModel;

  /// 点击回调函数
  final OnAnimeTap onAnimeTap;

  /// 动漫类型，用于生成唯一的 Hero 动画标签
  final AnimeType animeType;

  /// 展示的卡片数量（默认 12，按窗口宽度自动分行）
  final int itemCount;

  const HorizontalAnimes({
    required this.animeViewModel,
    required this.onAnimeTap,
    required this.animes,
    required this.animeType,
    this.itemCount = 12,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final items = animes.take(itemCount).toList();
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }
        final columns = columnsForWidth(constraints.maxWidth);
        final rows = (items.length / columns).ceil();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              for (var row = 0; row < rows; row++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var col = 0; col < columns; col++)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: col == 0 ? 0 : 16),
                            child: row * columns + col < items.length
                                ? AnimeWidget(
                                    anime: items[row * columns + col],
                                    animeViewModel: animeViewModel,
                                    onAnimeTap: onAnimeTap,
                                    animeType: animeType,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// 根据可用宽度决定列数（列数取 12 的约数，保证行内满排不留空位）
  int columnsForWidth(double width) {
    if (width >= 1200) return 6;
    if (width >= 1000) return 4;
    if (width >= 650) return 3;
    return 2;
  }
}
