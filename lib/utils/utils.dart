import 'package:flutter/material.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/data/models/anime_image_configuration.dart';
import 'package:movies/data/models/anime_video.dart';
import 'package:movies/data/database/models/database_models.dart';

Widget addVerticalSpace(double amount) {
  return SizedBox(height: amount);
}

Widget addHorizontalSpace(double amount) {
  return SizedBox(width: amount);
}

/// 图片用途尺寸（对标书里 ImageSize，映射到 Bangumi 尺寸键）
enum ImageSize {
  /// 列表缩略（grid / small）
  small,

  /// 中等（common / medium）
  medium,

  /// 详情大图（large）
  large,
}

/// Bangumi 尺寸键在 [ImageSize] 下的偏好顺序
const Map<ImageSize, List<String>> _sizePreference = {
  ImageSize.small: ['grid', 'small', 'medium', 'common', 'large'],
  ImageSize.medium: ['common', 'medium', 'large', 'small', 'grid'],
  ImageSize.large: ['large', 'medium', 'common', 'small', 'grid'],
};

/// Bangumi /r/{width}/ 缩放宽度偏好
const Map<ImageSize, int> _resizeWidth = {
  ImageSize.small: 200,
  ImageSize.medium: 400,
  ImageSize.large: 1200,
};

/// 按配置拼/改图片 URL
/// [file] 可为完整 Bangumi/AniList URL，或仅路径；配置负责尺寸与缩放
String? imageUrl(String baseUrl, String size, String file) {
  if (file.isEmpty) return null;
  if (file.startsWith('http://') || file.startsWith('https://')) {
    return file;
  }
  final normalizedBase =
      baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
  final normalizedFile = file.startsWith('/') ? file : '/$file';
  final normalizedSize = size.isEmpty
      ? ''
      : (size.startsWith('/') ? size : '/$size');
  return '$normalizedBase$normalizedSize$normalizedFile';
}

/// 按 [ImageSize] 从 images 对象取图
String? getSizedImageUrl(
  ImageSize size,
  AnimeImageConfiguration configuration,
  Map<String, dynamic>? images,
) {
  if (images == null || images.isEmpty) return null;
  final prefer = _sizePreference[size];
  if (prefer != null) {
    for (final key in prefer) {
      final url = images[key];
      if (url is String && url.isNotEmpty) {
        return configuration.bangumiResize(
          url,
          _resizeWidth[size] ?? 800,
        );
      }
    }
  }
  final url = configuration.pick(images);
  return url.isEmpty ? null : url;
}

/// 对完整 Bangumi URL 按 [ImageSize] 改写尺寸/缩放
String? resizeBangumiUrl(
  ImageSize size,
  AnimeImageConfiguration configuration,
  String? url,
) {
  if (url == null || url.isEmpty) return null;
  final pathSize = switch (size) {
    ImageSize.small => 's',
    ImageSize.medium => 'c',
    ImageSize.large => 'l',
  };
  final withSize = configuration.bangumiWithSize(url, _pathSizeKey(pathSize));
  return configuration.bangumiResize(
    withSize,
    _resizeWidth[size] ?? 800,
  );
}

/// 详情页大图：优先封面，可回退
String? getAnimeDetailsImagePath(
  AnimeDetails details,
  AnimeImageConfiguration configuration,
) {
  final image = details.image;
  if (image.isEmpty) return null;
  return resizeBangumiUrl(ImageSize.large, configuration, image);
}

/// 用 DBFavorite 的图路径取缩略图
String? getFavoriteImageUrl(
  ImageSize size,
  AnimeImageConfiguration configuration,
  String? imagePath,
) {
  return resizeBangumiUrl(size, configuration, imagePath);
}

/// 路径尺寸段对应的配置键（large/medium/...）
String _pathSizeKey(String pathSize) {
  return switch (pathSize) {
    'l' => 'large',
    'm' => 'medium',
    'c' => 'common',
    's' => 'small',
    'g' => 'grid',
    _ => 'large',
  };
}

/// 动漫点击回调类型
typedef OnAnimeTap = void Function(int animeId);

/// 视频点击回调类型
typedef OnAnimeVideoTap = void Function(AnimeVideo video);

/// 收藏结果点击回调类型
typedef OnFavoriteResultsTap = void Function(DBFavorite favorite);

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
