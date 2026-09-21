import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anime.g.dart';

/// 解析日期字符串为 DateTime
DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is String) {
    try {
      return DateFormat('yyyy-MM-dd').parse(value);
    } catch (e) {
      return null;
    }
  }
  return null;
}

/// 解析 aired 字段（Jikan API 返回的是 Map 对象）
DateTime? _parseAired(dynamic value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) {
    final from = value['from'] as String?;
    if (from != null && from.isNotEmpty) {
      try {
        // 格式: "2023-10-05T00:00:00+00:00"
        return DateTime.parse(from);
      } catch (e) {
        return null;
      }
    }
  }
  return null;
}

/// 动漫数据模型
@JsonSerializable()
class Anime {
  @JsonKey(name: 'mal_id')
  final int malId;

  final String? title;

  @JsonKey(name: 'title_english')
  final String? titleEnglish;

  final Images? images;

  final bool? airing;

  final double? score;

  @JsonKey(name: 'scored_by')
  final int? scoredBy;

  final int? rank;

  final int? members;

  final String? type;

  final String? status;

  final int? episodes;

  @JsonKey(fromJson: _parseAired)
  final DateTime? aired;

  final String? synopsis;

  final String? background;

  final String? season;

  final int? year;

  @JsonKey(name: 'rating')
  final String? ratingClass;

  const Anime({
    required this.malId,
    this.title,
    this.titleEnglish,
    this.images,
    this.airing,
    this.score,
    this.scoredBy,
    this.rank,
    this.members,
    this.type,
    this.status,
    this.episodes,
    this.aired,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.ratingClass,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeToJson(this);

  /// 获取封面图片 URL
  String get imageUrl =>
      images?.jpg?.largeImageUrl ?? images?.jpg?.imageUrl ?? '';

  /// 兼容旧代码的字段名
  int get animeId => malId;
  String get image => imageUrl;
}

/// 图片数据模型
@JsonSerializable()
class Images {
  final Jpg? jpg;
  final WebP? webp;

  const Images({this.jpg, this.webp});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

/// JPG 格式图片数据模型
@JsonSerializable()
class Jpg {
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'small_image_url')
  final String? smallImageUrl;

  @JsonKey(name: 'large_image_url')
  final String? largeImageUrl;

  const Jpg({this.imageUrl, this.smallImageUrl, this.largeImageUrl});

  factory Jpg.fromJson(Map<String, dynamic> json) => _$JpgFromJson(json);

  Map<String, dynamic> toJson() => _$JpgToJson(this);
}

/// WebP 格式图片数据模型
@JsonSerializable()
class WebP {
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'small_image_url')
  final String? smallImageUrl;

  @JsonKey(name: 'large_image_url')
  final String? largeImageUrl;

  const WebP({this.imageUrl, this.smallImageUrl, this.largeImageUrl});

  factory WebP.fromJson(Map<String, dynamic> json) => _$WebPFromJson(json);

  Map<String, dynamic> toJson() => _$WebPToJson(this);
}
