import 'package:json_annotation/json_annotation.dart';
import 'package:movies/data/models/genre.dart';

part 'anime_details.g.dart';

/// 动漫详情数据模型
/// Jikan API 返回的完整动漫信息
@JsonSerializable()
class AnimeDetails {
  /// 动漫 ID
  @JsonKey(name: 'mal_id')
  final int? malId;

  /// 动漫标题
  final String? title;

  /// 英文标题
  @JsonKey(name: 'title_english')
  final String? titleEnglish;

  /// 日文标题
  @JsonKey(name: 'title_japanese')
  final String? titleJapanese;

  /// 图片信息
  final dynamic images;

  /// 类型 (TV, Movie, OVA, etc.)
  final String? type;

  /// 来源 (Manga, Original, etc.)
  final String? source;

  /// 集数
  final int? episodes;

  /// 状态 (Finished Airing, Currently Airing, etc.)
  final String? status;

  /// 是否正在播出
  final bool? airing;

  /// 开始日期信息
  final dynamic aired;

  /// 时长
  final String? duration;

  /// 评分等级
  final String? rating;

  /// 评分
  final double? score;

  /// 评分人数
  @JsonKey(name: 'scored_by')
  final int? scoredBy;

  /// 排名
  final int? rank;

  /// 人气
  final int? popularity;

  /// 成员数
  final int? members;

  /// 收藏数
  final int? favorites;

  /// 简介
  final String? synopsis;

  /// 背景
  final String? background;

  /// 季节
  final String? season;

  /// 年份
  final int? year;

  /// 类型列表
  final List<Genre>? genres;

  /// 制作公司
  final List<dynamic>? studios;

  const AnimeDetails({
    this.malId,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.images,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.genres,
    this.studios,
  });

  factory AnimeDetails.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeDetailsToJson(this);

  /// 获取封面图片 URL
  String get imageUrl {
    if (images is Map<String, dynamic>) {
      final jpg = images['jpg'] as Map<String, dynamic>?;
      if (jpg != null) {
        return jpg['large_image_url'] ?? jpg['image_url'] ?? '';
      }
    }
    return '';
  }

  /// 获取背景图片 URL
  String get backdropUrl {
    if (images is Map<String, dynamic>) {
      final jpg = images['jpg'] as Map<String, dynamic>?;
      if (jpg != null) {
        return jpg['large_image_url'] ?? jpg['image_url'] ?? '';
      }
    }
    return '';
  }

  /// 获取标题（优先英文，其次日文）
  String get displayTitle => titleEnglish ?? title ?? '';
}
