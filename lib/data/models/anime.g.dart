// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Anime _$AnimeFromJson(Map<String, dynamic> json) => Anime(
  malId: (json['mal_id'] as num?)?.toInt(),
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
  aired: _parseAired(json['aired']),
  synopsis: json['synopsis'] as String?,
  background: json['background'] as String?,
  season: json['season'] as String?,
  year: (json['year'] as num?)?.toInt(),
  ratingClass: json['rating'] as String?,
);

Map<String, dynamic> _$AnimeToJson(Anime instance) => <String, dynamic>{
  'mal_id': instance.malId,
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
  'rating': instance.ratingClass,
};

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
  jpg: json['jpg'] == null
      ? null
      : Jpg.fromJson(json['jpg'] as Map<String, dynamic>),
  webp: json['webp'] == null
      ? null
      : WebP.fromJson(json['webp'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
  'jpg': instance.jpg,
  'webp': instance.webp,
};

Jpg _$JpgFromJson(Map<String, dynamic> json) => Jpg(
  imageUrl: json['image_url'] as String?,
  smallImageUrl: json['small_image_url'] as String?,
  largeImageUrl: json['large_image_url'] as String?,
);

Map<String, dynamic> _$JpgToJson(Jpg instance) => <String, dynamic>{
  'image_url': instance.imageUrl,
  'small_image_url': instance.smallImageUrl,
  'large_image_url': instance.largeImageUrl,
};

WebP _$WebPFromJson(Map<String, dynamic> json) => WebP(
  imageUrl: json['image_url'] as String?,
  smallImageUrl: json['small_image_url'] as String?,
  largeImageUrl: json['large_image_url'] as String?,
);

Map<String, dynamic> _$WebPToJson(WebP instance) => <String, dynamic>{
  'image_url': instance.imageUrl,
  'small_image_url': instance.smallImageUrl,
  'large_image_url': instance.largeImageUrl,
};
