// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnimeImpl _$$AnimeImplFromJson(Map<String, dynamic> json) => _$AnimeImpl(
      malId: (json['malId'] as num).toInt(),
      title: json['title'] as String?,
      titleEnglish: json['title_english'] as String?,
      images: json['images'] == null
          ? null
          : Images.fromJson(json['images'] as Map<String, dynamic>),
      airing: json['airing'] as bool?,
      score: (json['score'] as num?)?.toDouble(),
      scoredBy: (json['scored_by'] as num?)?.toInt(),
      rank: (json['rank'] as num?)?.toInt(),
      members: (json['members'] as num?)?.toInt(),
      type: json['type'] as String?,
      status: json['status'] as String?,
      episodes: (json['episodes'] as num?)?.toInt(),
      aired: _parseDate(json['aired'] as String?),
      synopsis: json['synopsis'] as String?,
      background: json['background'] as String?,
      season: json['season'] as String?,
      year: (json['year'] as num?)?.toInt(),
      rating: json['rating'] as String?,
    );

Map<String, dynamic> _$$AnimeImplToJson(_$AnimeImpl instance) =>
    <String, dynamic>{
      'malId': instance.malId,
      'title': instance.title,
      'title_english': instance.titleEnglish,
      'images': instance.images,
      'airing': instance.airing,
      'score': instance.score,
      'scored_by': instance.scoredBy,
      'rank': instance.rank,
      'members': instance.members,
      'type': instance.type,
      'status': instance.status,
      'episodes': instance.episodes,
      'aired': instance.aired?.toIso8601String(),
      'synopsis': instance.synopsis,
      'background': instance.background,
      'season': instance.season,
      'year': instance.year,
      'rating': instance.rating,
    };

_$ImagesImpl _$$ImagesImplFromJson(Map<String, dynamic> json) => _$ImagesImpl(
      jpg: json['jpg'] == null
          ? null
          : Jpg.fromJson(json['jpg'] as Map<String, dynamic>),
      webp: json['webp'] == null
          ? null
          : WebP.fromJson(json['webp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ImagesImplToJson(_$ImagesImpl instance) =>
    <String, dynamic>{
      'jpg': instance.jpg,
      'webp': instance.webp,
    };

_$JpgImpl _$$JpgImplFromJson(Map<String, dynamic> json) => _$JpgImpl(
      image_url: json['image_url'] as String?,
      small_image_url: json['small_image_url'] as String?,
      large_image_url: json['large_image_url'] as String?,
    );

Map<String, dynamic> _$$JpgImplToJson(_$JpgImpl instance) => <String, dynamic>{
      'image_url': instance.image_url,
      'small_image_url': instance.small_image_url,
      'large_image_url': instance.large_image_url,
    };

_$WebPImpl _$$WebPImplFromJson(Map<String, dynamic> json) => _$WebPImpl(
      image_url: json['image_url'] as String?,
      small_image_url: json['small_image_url'] as String?,
      large_image_url: json['large_image_url'] as String?,
    );

Map<String, dynamic> _$$WebPImplToJson(_$WebPImpl instance) =>
    <String, dynamic>{
      'image_url': instance.image_url,
      'small_image_url': instance.small_image_url,
      'large_image_url': instance.large_image_url,
    };
