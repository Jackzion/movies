import 'package:movies/data/models/anime_image_configuration.dart';

/// 图片配置数据库模型（对标书中 DBConfiguration）
/// 尺寸列表以逗号分隔存库，读入时拆回 List
class DBAnimeImageConfiguration {
  /// 本地行 ID
  final int id;

  /// 图片配置
  final AnimeImageConfiguration configuration;

  const DBAnimeImageConfiguration({
    required this.id,
    required this.configuration,
  });

  factory DBAnimeImageConfiguration.fromJson(Map<String, dynamic> json) {
    return DBAnimeImageConfiguration(
      id: json['id'] as int? ?? 1,
      configuration: AnimeImageConfiguration.fromJson(
        (json['configuration'] as Map<String, dynamic>?) ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'configuration': configuration.toJson(),
      };
}
