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

/// 动漫卡片展示组件
/// 竖版海报（2:3）+ 评分角标 + 标题/副标题，悬停时轻微上浮
/// 支持 Hero 动画过渡效果，点击后跳转到动漫详情页
class AnimeWidget extends ConsumerStatefulWidget {
  /// 动漫数据对象
  final Anime anime;

  /// 点击回调函数
  final OnAnimeTap onAnimeTap;

  /// 动漫类型，用于生成唯一的 Hero 动画标签
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

  /// 是否处于悬停状态（桌面端上浮效果）
  bool hovered = false;

  @override
  void initState() {
    super.initState();
    // 根据动漫地址和类型生成唯一的 Hero 标签
    uniqueHeroTag = widget.anime.imageUrl + widget.animeType.name;
  }

  @override
  Widget build(BuildContext context) {
    final anime = widget.anime;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: () {
          // 设置当前的 Hero 标签，用于详情页动画
          ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
          widget.onAnimeTap(anime.animeId);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: hovered ? const Color(0x80000000) : const Color(0x40000000),
                blurRadius: hovered ? 24 : 8,
                offset: Offset(0, hovered ? 12 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 海报（2:3）+ 评分角标
              AspectRatio(
                aspectRatio: 2 / 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: uniqueHeroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: anime.image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              buildFallback(context),
                        ),
                      ),
                    ),
                    if (anime.score != null)
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xBF000000),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            anime.score!.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              addVerticalSpace(8),
              // 标题
              Text(
                anime.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              addVerticalSpace(2),
              // 副标题
              Text(
                subtitleOf(anime),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: const Color(0xFF9CA3AF)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 副标题：优先简介，其次年份与放送形式
  String subtitleOf(Anime anime) {
    final synopsis = anime.synopsis ?? '';
    if (synopsis.isNotEmpty) {
      return synopsis;
    }
    final meta = <String>[
      if (anime.aired != null) '${anime.aired!.year}',
      if (anime.type != null && anime.type!.isNotEmpty) anime.type!,
    ];
    return meta.join(' · ');
  }

  /// 图片加载失败时的回退占位
  Widget buildFallback(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF374151), Color(0xFF111827)],
        ),
      ),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text(
        widget.anime.title ?? '',
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
