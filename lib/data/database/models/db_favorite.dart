/// 收藏动漫数据库模型
/// 存全量字段，重启后无需再打网络就能恢复收藏列表
class DBFavorite {
  /// 本地行 ID
  final int id;

  /// Bangumi 条目 ID
  final int animeId;

  /// 封面图 URL/路径
  final String posterPath;

  /// 宽幅横幅 URL/路径（可空）
  final String? bannerPath;

  /// 是否收藏
  final bool favorite;

  /// 热度/评分
  final double popularity;

  /// 首播日期
  final DateTime releaseDate;

  /// 标题
  final String title;

  /// 简介
  final String overview;

  const DBFavorite({
    required this.id,
    required this.animeId,
    required this.posterPath,
    this.bannerPath,
    required this.favorite,
    required this.popularity,
    required this.releaseDate,
    required this.title,
    required this.overview,
  });

  factory DBFavorite.fromJson(Map<String, dynamic> json) {
    return DBFavorite(
      id: json['id'] as int? ?? 0,
      animeId: json['animeId'] as int? ?? 0,
      posterPath: json['posterPath'] as String? ?? '',
      bannerPath: json['bannerPath'] as String?,
      favorite: json['favorite'] as bool? ?? true,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      releaseDate: DateTime.tryParse(json['releaseDate'] as String? ?? '') ??
          DateTime.now(),
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'animeId': animeId,
        'posterPath': posterPath,
        'bannerPath': bannerPath,
        'favorite': favorite,
        'popularity': popularity,
        'releaseDate': releaseDate.toIso8601String(),
        'title': title,
        'overview': overview,
      };
}
