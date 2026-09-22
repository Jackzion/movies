import 'package:flutter/material.dart';
import 'package:movies/data/models/anime_video.dart';
import 'package:movies/data/models/favorite.dart';

Widget addVerticalSpace(double amount) {
  return SizedBox(height: amount);
}

Widget addHorizontalSpace(double amount) {
  return SizedBox(width: amount);
}

/// 动漫点击回调类型
typedef OnAnimeTap = void Function(int animeId);

/// 视频点击回调类型
typedef OnAnimeVideoTap = void Function(AnimeVideo video);

/// 收藏结果点击回调类型
typedef OnFavoriteResultsTap = void Function(Favorite favorite);

String youtubeUrlFromId(String videoId) {
  return 'https://www.youtube.com/watch?v=$videoId';
}

/// 排序方式枚举
enum Sorting {
  aToz(name: 'A-Z'),
  zToa(name: 'Z-A'),
  rating(name: 'Rating'),
  year(name: 'Year');

  const Sorting({required this.name});
  final String name;
}
