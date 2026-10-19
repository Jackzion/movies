// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
  malId: (json['mal_id'] as num).toInt(),
  name: json['name'] as String,
  count: (json['count'] as num?)?.toInt(),
);

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
  'mal_id': instance.malId,
  'name': instance.name,
  'count': instance.count,
};
