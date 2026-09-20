/// 电影数据模型
/// 包含电影的基本信息：ID、图片、标题、简介、热度、上映日期
class Movie {
  /// 电影 ID
  final int movieId;
  /// 电影封面图片地址
  final String image;
  /// 电影标题
  final String title;
  /// 电影简介
  final String overview;
  /// 电影热度值
  final double popularity;
  /// 上映日期
  final DateTime releaseDate;

  const Movie({
    required this.movieId,
    required this.image,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
  });
}
