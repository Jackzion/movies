/// AniList 补充数据
/// 包含 Bangumi 缺失的宽幅横幅图和 PV（YouTube ID），按需加载并缓存
class AnimeExtras {
  /// 宽幅横幅图地址
  final String? bannerImage;

  /// PV 的 YouTube 视频 ID
  final String? youtubeId;

  const AnimeExtras({this.bannerImage, this.youtubeId});

  /// 从缓存 JSON 构造
  factory AnimeExtras.fromJson(Map<String, dynamic> json) {
    return AnimeExtras(
      bannerImage: json['banner'] as String?,
      youtubeId: json['yt'] as String?,
    );
  }

  /// 转为缓存 JSON
  Map<String, dynamic> toJson() => {
        'banner': bannerImage,
        'yt': youtubeId,
      };
}
