/// 收藏动漫数据模型
/// 包含动漫的基本信息和收藏状态
class Favorite {
  /// 动漫 ID
  final int animeId;
  /// 电影封面图片地址
  final String image;
  /// 是否已收藏（可变）
  bool favorite;
  /// 电影标题
  final String title;
  /// 电影简介
  final String overview;
  /// 电影热度值
  final double popularity;
  /// 上映日期
  final DateTime releaseDate;

  Favorite({
    required this.animeId,
    required this.image,
    required this.favorite,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
  });
}
