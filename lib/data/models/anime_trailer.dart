/// 动漫预告片 / PV 数据模型
/// 来源：Jikan trailer 字段，或 AniList Media.trailer
class AnimeTrailer {
  /// 预告片标题
  final String? title;

  /// 视频 ID（YouTube / Dailymotion）
  final String? youtubeId;

  /// 托管站点：youtube / dailymotion
  final String? site;

  /// 远端缩略图 URL（AniList trailer.thumbnail 或 Jikan images）
  final String? imageUrl;

  const AnimeTrailer({
    this.title,
    this.youtubeId,
    this.site,
    this.imageUrl,
  });

  /// Jikan API：youtube_id / images 嵌套在 trailer 字段下
  factory AnimeTrailer.fromJson(Map<String, dynamic> json) {
    final trailer = json['trailer'] as Map<String, dynamic>?;
    final images = trailer?['images'] as Map<String, dynamic>?;
    return AnimeTrailer(
      title: json['title'] as String?,
      youtubeId: trailer?['youtube_id'] as String?,
      site: trailer?['site'] as String? ?? 'youtube',
      imageUrl: images?['medium_image_url'] as String?,
    );
  }

  /// AniList Media.trailer：id / site / thumbnail
  factory AnimeTrailer.fromAniList(
    Map<String, dynamic> trailer, {
    String? title,
  }) {
    return AnimeTrailer(
      title: title ?? 'PV',
      youtubeId: trailer['id'] as String?,
      site: trailer['site'] as String?,
      imageUrl: trailer['thumbnail'] as String?,
    );
  }

  /// 是否 Dailymotion 源
  bool get isDailymotion => site == 'dailymotion';

  /// 缩略图 URL：优先远端图，否则按 YouTube ID 拼 hqdefault
  String get thumbnailUrl {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return imageUrl!;
    }
    if (youtubeId != null && youtubeId!.isNotEmpty && !isDailymotion) {
      return 'https://img.youtube.com/vi/$youtubeId/hqdefault.jpg';
    }
    return '';
  }

  /// 视频播放页链接（AniList 不返回 watch 直链，由 id 拼出）
  String get videoUrl {
    final id = youtubeId;
    if (id == null || id.isEmpty) {
      return '';
    }
    if (isDailymotion) {
      return 'https://www.dailymotion.com/video/$id';
    }
    return 'https://www.youtube.com/watch?v=$id';
  }
}
