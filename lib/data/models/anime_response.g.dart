// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeResponse _$AnimeResponseFromJson(Map<String, dynamic> json) =>
    AnimeResponse(
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
      data: (json['data'] as List<dynamic>)
          .map((e) => Anime.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNextPage: json['has_next_page'] as bool?,
    );

Map<String, dynamic> _$AnimeResponseToJson(AnimeResponse instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'data': instance.data,
      'has_next_page': instance.hasNextPage,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  lastVisiblePage: (json['last_visible_page'] as num?)?.toInt(),
  hasNextPage: json['has_next_page'] as bool?,
  currentPage: (json['current_page'] as num?)?.toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'last_visible_page': instance.lastVisiblePage,
      'has_next_page': instance.hasNextPage,
      'current_page': instance.currentPage,
    };
