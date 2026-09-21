import 'package:json_annotation/json_annotation.dart';
import 'package:movies/data/models/anime.dart';

part 'anime_response.g.dart';

/// Jikan API 响应数据模型
@JsonSerializable()
class AnimeResponse {
  /// 分页信息
  final Pagination pagination;

  /// 动漫列表数据
  final List<Anime> data;

  /// 是否有下一页
  @JsonKey(name: 'has_next_page')
  final bool? hasNextPage;

  const AnimeResponse({
    required this.pagination,
    required this.data,
    this.hasNextPage,
  });

  factory AnimeResponse.fromJson(Map<String, dynamic> json) =>
      _$AnimeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnimeResponseToJson(this);
}

/// Jikan API 分页信息响应模型
@JsonSerializable()
class Pagination {
  /// 最后一页页码
  @JsonKey(name: 'last_visible_page')
  final int? lastVisiblePage;

  /// 是否有下一页
  @JsonKey(name: 'has_next_page')
  final bool? hasNextPage;

  /// 当前页
  @JsonKey(name: 'current_page')
  final int? currentPage;

  const Pagination({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
