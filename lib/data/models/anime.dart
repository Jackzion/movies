import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'anime.freezed.dart';
part 'anime.g.dart';

/// 解析日期字符串为 DateTime
/// Jikan API 返回的日期格式为 yyyy-MM-dd
DateTime? _parseDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return null;
  }
  try {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  } catch (e) {
    return null;
  }
}

/// 动漫数据模型
/// 使用 freezed 生成不可变类和 JSON 序列化代码
@freezed
class Anime with _$Anime {
  const factory Anime({
    /// 动漫 ID
    required int malId,

    /// 动漫标题
    String? title,

    /// 英文标题
    @JsonKey(name: 'title_english') String? titleEnglish,

    /// 图片 URL
    Images? images,

    /// 是否正在播出
    @JsonKey(name: 'airing') bool? airing,

    /// 评分
    double? score,

    /// 评分人数
    @JsonKey(name: 'scored_by') int? scoredBy,

    /// 排名
    int? rank,

    /// 成员数
    int? members,

    /// 类型 (TV, Movie, OVA, etc.)
    String? type,

    /// 状态 (Finished Airing, Currently Airing, Not yet aired)
    String? status,

    /// 播放集数
    @JsonKey(name: 'episodes') int? episodes,

    /// 开始日期
    @JsonKey(name: 'aired', fromJson: _parseDate) DateTime? aired,

    /// 简介
    String? synopsis,

    /// 背景
    String? background,

    /// 季节
    String? season,

    /// 年份
    int? year,

    /// 评分等级
    @JsonKey(name: 'rating') String? rating,
  }) = _Anime;

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);
}

/// 图片数据模型
@freezed
class Images with _$Images {
  const factory Images({
    /// JPG 格式图片
    Jpg? jpg,

    /// WebP 格式图片
    WebP? webp,
  }) = _Images;

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
}

/// JPG 格式图片数据模型
@freezed
class Jpg with _$Jpg {
  const factory Jpg({
    /// 图片 URL
    String? image_url,

    /// 小尺寸图片 URL
    String? small_image_url,

    /// 大尺寸图片 URL
    String? large_image_url,
  }) = _Jpg;

  factory Jpg.fromJson(Map<String, dynamic> json) => _$JpgFromJson(json);
}

/// WebP 格式图片数据模型
@freezed
class WebP with _$WebP {
  const factory WebP({
    /// 图片 URL
    String? image_url,

    /// 小尺寸图片 URL
    String? small_image_url,

    /// 大尺寸图片 URL
    String? large_image_url,
  }) = _WebP;

  factory WebP.fromJson(Map<String, dynamic> json) => _$WebPFromJson(json);
}
