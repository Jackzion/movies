// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnimeResponseImpl _$$AnimeResponseImplFromJson(Map<String, dynamic> json) =>
    _$AnimeResponseImpl(
      pagination: (json['pagination'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => Anime.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNextPage: json['has_next_page'] as bool?,
    );

Map<String, dynamic> _$$AnimeResponseImplToJson(_$AnimeResponseImpl instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'data': instance.data,
      'has_next_page': instance.hasNextPage,
    };

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      lastVisiblePage: (json['last_visible_page'] as num?)?.toInt(),
      hasNextPage: json['has_next_page'] as bool?,
      currentPage: (json['current_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'last_visible_page': instance.lastVisiblePage,
      'has_next_page': instance.hasNextPage,
      'current_page': instance.currentPage,
    };
