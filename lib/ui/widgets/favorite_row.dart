import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/favorite.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/movie_viewmodel.dart';

/// 收藏电影行展示组件
/// 显示电影封面、标题、年份和收藏按钮
class FavoriteRow extends StatelessWidget {
  /// 收藏电影数据
  final Favorite favorite;
  /// 电影视图模型
  final MovieViewModel movieViewModel;
  /// 点击回调函数
  final OnMovieTap onMovieTap;
  /// 收藏按钮点击回调
  final OnFavoriteResultsTap onFavoritesTap;

  const FavoriteRow({
    super.key,
    required this.favorite,
    required this.movieViewModel,
    required this.onMovieTap,
    required this.onFavoritesTap,
  });

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度，用于计算文本宽度
    final screenWidth = MediaQuery.of(context).size.width;
    final textWidth = screenWidth - 132;

    final imageUrl = favorite.image;
    if (imageUrl.isNotEmpty) {
      return GestureDetector(
        onTap: () => onMovieTap(favorite.movieId),
        child: SizedBox(
          height: 148,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              addHorizontalSpace(16),
              // 电影封面图片
              SizedBox(
                height: 140,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  height: 140,
                  width: 100,
                ),
              ),
              addHorizontalSpace(16),
              // 使用 Stack 叠加收藏按钮和文本信息
              Stack(
                children: [
                  // 收藏按钮，位于右上角
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () => onFavoritesTap(favorite),
                      icon: favorite.favorite
                          ? const Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  // 电影信息文本
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 电影标题
                          SizedBox(
                            width: textWidth,
                            child: AutoSizeText(
                              favorite.title,
                              maxLines: 1,
                              minFontSize: 10,
                              style: Theme.of(context).textTheme.labelLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          addVerticalSpace(4),
                          // 上映年份
                          Text(
                            favorite.releaseDate.year.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          addVerticalSpace(4),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
