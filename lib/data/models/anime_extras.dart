/// AniList 补充数据
/// 包含 Bangumi 缺失的宽幅横幅图和 PV（trailer），按需加载并缓存
class AnimeExtras {
  /// 宽幅横幅图地址
  final String? bannerImage;

  /// PV 视频 ID（YouTube / Dailymotion）
  final String? youtubeId;

  /// PV 托管站点：youtube / dailymotion
  final String? trailerSite;

  /// PV 缩略图 URL（AniList trailer.thumbnail）
  final String? trailerThumbnail;

  const AnimeExtras({
    this.bannerImage,
    this.youtubeId,
    this.trailerSite,
    this.trailerThumbnail,
  });

  /// 从缓存 JSON 构造
  factory AnimeExtras.fromJson(Map<String, dynamic> json) {
    return AnimeExtras(
      bannerImage: json['banner'] as String?,
      youtubeId: json['yt'] as String?,
      trailerSite: json['yt_site'] as String?,
      trailerThumbnail: json['yt_thumb'] as String?,
    );
  }

  /// 转为缓存 JSON
  Map<String, dynamic> toJson() => {
        'banner': bannerImage,
        'yt': youtubeId,
        'yt_site': trailerSite,
        'yt_thumb': trailerThumbnail,
      };
}
