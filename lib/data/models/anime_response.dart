import 'package:json_annotation/json_annotation.dart';
import 'package:movies/data/models/anime.dart';

part 'anime_response.g.dart';

@JsonSerializable()
class AnimeResponse {
  final Pagination pagination;
  final List<Anime> data;
  @JsonKey(name: 'has_next_page')
  final bool? hasNextPage;

  const AnimeResponse({required this.pagination, required this.data, this.hasNextPage});

  factory AnimeResponse.fromJson(Map<String, dynamic> json) => _$AnimeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'last_visible_page')
  final int? lastVisiblePage;
  @JsonKey(name: 'has_next_page')
  final bool? hasNextPage;
  @JsonKey(name: 'current_page')
  final int? currentPage;

  const Pagination({this.lastVisiblePage, this.hasNextPage, this.currentPage});

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
