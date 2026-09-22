/// 动漫视频数据模型
/// Jikan API 返回的预告片/ED/OP 视频信息
class AnimeVideo {
  /// 视频标题
  final String? title;

  /// 视频 ID (YouTube ID)
  final String? youtubeId;

  /// 视频缩略图 URL
  final String? imageUrl;

  const AnimeVideo({
    this.title,
    this.youtubeId,
    this.imageUrl,
  });

  factory AnimeVideo.fromJson(Map<String, dynamic> json) {
    return AnimeVideo(
      title: json['title'] as String?,
      youtubeId: json['youtube_id'] as String?,
      imageUrl: json['images']?['medium_image_url'] as String?,
    );
  }

  /// 获取 YouTube 缩略图 URL
  String get thumbnailUrl {
    if (youtubeId != null && youtubeId!.isNotEmpty) {
      return 'https://img.youtube.com/vi/$youtubeId/hqdefault.jpg';
    }
    return imageUrl ?? '';
  }

  /// 获取 YouTube 视频链接
  String get videoUrl {
    if (youtubeId != null && youtubeId!.isNotEmpty) {
      return 'https://www.youtube.com/watch?v=$youtubeId';
    }
    return '';
  }
}
