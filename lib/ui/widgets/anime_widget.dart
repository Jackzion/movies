import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/providers.dart';
import 'package:movies/utils/utils.dart';

/// 动漫类型枚举，用于区分不同分类的动漫
/// 用于生成唯一的 Hero 动画标签
enum AnimeType {
  trending,
  popular,
  topRated,
  nowPlaying,
}

/// 动漫图片展示组件
/// 支持 Hero 动画过渡效果，点击后跳转到动漫详情页
class AnimeWidget extends ConsumerStatefulWidget {
  /// 动漫数据对象
  final Anime anime;
  /// 点击回调函数
  final OnAnimeTap onAnimeTap;
  /// 动漫类型，用于生成唯一的 Hero 标签
  final AnimeType animeType;

  const AnimeWidget({
    required this.anime,
    required this.onAnimeTap,
    required this.animeType,
    super.key,
  });

  @override
  ConsumerState<AnimeWidget> createState() => _AnimeWidgetState();
}

class _AnimeWidgetState extends ConsumerState<AnimeWidget> {
  /// 唯一的 Hero 动画标签，由动漫地址和类型组合生成
  late String uniqueHeroTag;

  @override
  void initState() {
    super.initState();
    // 根据动漫地址和类型生成唯一的 Hero 标签
    uniqueHeroTag = widget.anime.imageUrl + widget.animeType.name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 设置当前的 Hero 标签，用于详情页动画
        ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
        widget.onAnimeTap(widget.anime.animeId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 100,
          height: 142,
          child: Hero(
            tag: uniqueHeroTag,
            child: CachedNetworkImage(
              imageUrl: widget.anime.image,
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
