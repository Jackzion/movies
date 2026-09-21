import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies/data/models/anime.dart';

part 'anime_response.freezed.dart';
part 'anime_response.g.dart';

/// Jikan API 响应数据模型
/// 包含分页信息和动漫列表
@freezed
class AnimeResponse with _$AnimeResponse {
  const factory AnimeResponse({
    /// 当前页码
    required int pagination,

    /// 动漫列表数据
    required List<Anime> data,

    /// 是否有下一页
    @JsonKey(name: 'has_next_page') bool? hasNextPage,
  }) = _AnimeResponse;

  factory AnimeResponse.fromJson(Map<String, dynamic> json) =>
      _$AnimeResponseFromJson(json);
}

/// Jikan API 分页信息响应模型
@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    /// 当前页码
    @JsonKey(name: 'last_visible_page') int? lastVisiblePage,

    /// 是否有下一页
    @JsonKey(name: 'has_next_page') bool? hasNextPage,

    /// 当前页
    @JsonKey(name: 'current_page') int? currentPage,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
