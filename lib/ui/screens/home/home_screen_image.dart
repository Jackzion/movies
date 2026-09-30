import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/data/models/favorite.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/utils/utils.dart';

/// 轮播图自动播放延迟时间（毫秒）
const delayTime = 1000 * 10;

/// 图片切换动画过渡时间（毫秒）
const animationTime = 400;

/// 横幅高度
const heroHeight = 420.0;

/// 缩略图卡片宽度
const thumbWidth = 200.0;

/// 缩略图图片高度
const thumbImageHeight = 112.0;

/// 缩略图标签高度
const thumbLabelHeight = 33.0;

/// 缩略图边框宽度
const thumbBorder = 3.0;

/// 缩略图卡片间距
const thumbGap = 16.0;

/// 缩略图行内边距
const thumbPadding = EdgeInsets.symmetric(horizontal: 40, vertical: 20);

/// 首页轮播横幅组件
/// 上方为自动轮播的横幅大图，下方为缩略图列表，点击缩略图切换横幅
/// 播放按钮跳转详情页，收藏按钮更新收藏状态
class HomeScreenImage extends ConsumerStatefulWidget {
  /// 动漫视图模型
  final AnimeViewModel animeViewModel;

  /// 点击回调函数
  final OnAnimeTap onAnimeTap;

  const HomeScreenImage({
    required this.animeViewModel,
    required this.onAnimeTap,
    super.key,
  });

  @override
  ConsumerState<HomeScreenImage> createState() => _HomeScreenImageState();
}

class _HomeScreenImageState extends ConsumerState<HomeScreenImage> {
  /// 当前展示的动漫索引
  int currentIndex = 0;

  /// 自动轮播定时器
  Timer? autoPlayTimer;

  /// 缩略图列表滚动控制器
  final ScrollController thumbController = ScrollController();

  @override
  void initState() {
    super.initState();
    startAutoPlay();
  }

  @override
  void dispose() {
    autoPlayTimer?.cancel();
    thumbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animes = widget.animeViewModel.nowPlayingAnimes;
    if (animes.isEmpty) {
      return const SizedBox.shrink();
    }
    final currentAnime = animes[currentIndex];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildHero(context, currentAnime),
        buildThumbnailRow(context, animes),
      ],
    );
  }

  /// 横幅大图区域
  /// 包含背景大图、底部渐变信息栏（播放按钮、标题、简介）和收藏按钮
  Widget buildHero(BuildContext context, Anime anime) {
    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景大图（点击跳转详情页）
          GestureDetector(
            onTap: () => openDetail(anime),
            child: Hero(
              tag: '${anime.image}swiper',
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: animationTime),
                child: CachedNetworkImage(
                  key: ValueKey(anime.image),
                  imageUrl: anime.image,
                  fit: BoxFit.cover,
                  height: heroHeight,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          // 底部渐变信息栏
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                children: [
                  // 播放按钮
                  GestureDetector(
                    onTap: () => openDetail(anime),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0x4DFFFFFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  addHorizontalSpace(16),
                  // 标题和简介
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime.title ?? '',
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        addVerticalSpace(4),
                        Text(
                          anime.synopsis ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white70),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // 收藏按钮
                  buildFavoriteButton(anime),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 收藏按钮
  /// 点击切换收藏状态并更新收藏列表
  Widget buildFavoriteButton(Anime anime) {
    final favoriteSelected = isFavorite(anime);
    return GestureDetector(
      onTap: () => toggleFavorite(anime),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0x4D000000),
          shape: BoxShape.circle,
          border: Border.all(
            color: favoriteSelected
                ? const Color(0xFFFF4757)
                : const Color(0x80FFFFFF),
            width: 2,
          ),
        ),
        child: Icon(
          favoriteSelected ? Icons.favorite : Icons.favorite_border,
          color: favoriteSelected ? const Color(0xFFFF4757) : Colors.white,
          size: 24,
        ),
      ),
    );
  }

  /// 缩略图列表区域
  Widget buildThumbnailRow(BuildContext context, List<Anime> animes) {
    return SizedBox(
      height: thumbPadding.vertical +
          thumbImageHeight +
          thumbLabelHeight +
          thumbBorder * 2,
      child: ListView.builder(
        controller: thumbController,
        scrollDirection: Axis.horizontal,
        padding: thumbPadding,
        itemCount: animes.length,
        itemBuilder: (context, index) =>
            buildThumbnailCard(context, animes[index], index),
      ),
    );
  }

  /// 单个缩略图卡片
  /// 选中状态显示白色边框和光晕
  Widget buildThumbnailCard(BuildContext context, Anime anime, int index) {
    final active = index == currentIndex;
    return GestureDetector(
      onTap: () => selectIndex(index),
      child: Container(
        width: thumbWidth,
        margin: const EdgeInsets.only(right: thumbGap),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? const Color(0xCCFFFFFF) : Colors.transparent,
            width: thumbBorder,
          ),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x4DFFFFFF),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: anime.image,
              fit: BoxFit.cover,
              height: thumbImageHeight,
              width: thumbWidth,
            ),
            Container(
              height: thumbLabelHeight,
              color: const Color(0xB3000000),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                anime.title ?? '',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 跳转到动漫详情页
  void openDetail(Anime anime) {
    ref.read(heroTagProvider.notifier).state = '${anime.image}swiper';
    widget.onAnimeTap(anime.animeId);
  }

  /// 切换到指定缩略图，重置自动轮播计时器
  void selectIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    startAutoPlay();
    scrollToCurrent();
  }

  /// 启动自动轮播定时器
  void startAutoPlay() {
    autoPlayTimer?.cancel();
    autoPlayTimer =
        Timer.periodic(const Duration(milliseconds: delayTime), (_) {
      if (!mounted) {
        return;
      }
      final count = widget.animeViewModel.nowPlayingAnimes.length;
      if (count == 0) {
        return;
      }
      setState(() {
        currentIndex = (currentIndex + 1) % count;
      });
      scrollToCurrent();
    });
  }

  /// 将当前缩略图滚动到列表中间位置
  void scrollToCurrent() {
    if (!thumbController.hasClients) {
      return;
    }
    final itemPitch = thumbWidth + thumbGap;
    final itemCenter =
        thumbPadding.left + currentIndex * itemPitch + thumbWidth / 2;
    final target = (itemCenter - thumbController.position.viewportDimension / 2)
        .clamp(0.0, thumbController.position.maxScrollExtent);
    thumbController.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  /// 判断动漫是否已收藏
  bool isFavorite(Anime anime) {
    final favorites = widget.animeViewModel.favoriteList;
    if (favorites == null) {
      return false;
    }
    return favorites.any((fav) => fav.animeId == anime.animeId && fav.favorite);
  }

  /// 切换动漫收藏状态
  void toggleFavorite(Anime anime) {
    final favorites = widget.animeViewModel.favoriteList ??= [];
    final index = favorites.indexWhere((fav) => fav.animeId == anime.animeId);
    if (index != -1) {
      favorites[index].favorite = !favorites[index].favorite;
      widget.animeViewModel.updateFavorite(favorites[index]);
    } else {
      widget.animeViewModel.updateFavorite(Favorite(
        animeId: anime.animeId,
        image: anime.image,
        favorite: true,
        title: anime.title ?? '',
        overview: anime.synopsis ?? '',
        popularity: anime.score ?? 0,
        releaseDate: anime.aired ?? DateTime.now(),
      ));
    }
    setState(() {});
  }
}
