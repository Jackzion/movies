// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeDetails _$AnimeDetailsFromJson(Map<String, dynamic> json) => AnimeDetails(
  malId: (json['mal_id'] as num).toInt(),
  title: json['title'] as String?,
  titleEnglish: json['title_english'] as String?,
  titleJapanese: json['title_japanese'] as String?,
  images: json['images'],
  type: json['type'] as String?,
  source: json['source'] as String?,
  episodes: (json['episodes'] as num?)?.toInt(),
  status: json['status'] as String?,
  airing: json['airing'] as bool?,
  aired: json['aired'],
  duration: json['duration'] as String?,
  rating: json['rating'] as String?,
  score: (json['score'] as num?)?.toDouble(),
  scoredBy: (json['scored_by'] as num?)?.toInt(),
  rank: (json['rank'] as num?)?.toInt(),
  popularity: (json['popularity'] as num?)?.toInt(),
  members: (json['members'] as num?)?.toInt(),
  favorites: (json['favorites'] as num?)?.toInt(),
  synopsis: json['synopsis'] as String?,
  background: json['background'] as String?,
  season: json['season'] as String?,
  year: (json['year'] as num?)?.toInt(),
  genres: (json['genres'] as List<dynamic>?)
      ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
      .toList(),
  studios: json['studios'] as List<dynamic>?,
);

Map<String, dynamic> _$AnimeDetailsToJson(AnimeDetails instance) =>
    <String, dynamic>{
      'mal_id': instance.malId,
      'title': instance.title,
      'title_english': instance.titleEnglish,
      'title_japanese': instance.titleJapanese,
      'images': instance.images,
      'type': instance.type,
      'source': instance.source,
      'episodes': instance.episodes,
      'status': instance.status,
      'airing': instance.airing,
      'aired': instance.aired,
      'duration': instance.duration,
      'rating': instance.rating,
      'score': instance.score,
      'scored_by': instance.scoredBy,
      'rank': instance.rank,
      'popularity': instance.popularity,
      'members': instance.members,
      'favorites': instance.favorites,
      'synopsis': instance.synopsis,
      'background': instance.background,
      'season': instance.season,
      'year': instance.year,
      'genres': instance.genres,
      'studios': instance.studios,
    };
