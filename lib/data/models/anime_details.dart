import 'package:movies/data/models/genre.dart';

/// 动漫详情数据模型（手写 fromJson，处理 Jikan API 所有 null 场景）
class AnimeDetails {
  final int? malId;
  final String? title;
  final String? titleEnglish;
  final String? titleJapanese;
  final dynamic images;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool? airing;
  final dynamic aired;
  final String? duration;
  final String? rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int? popularity;
  final int? members;
  final int? favorites;
  final String? synopsis;
  final String? background;
  final String? season;
  final int? year;
  final List<Genre>? genres;
  final List<dynamic>? studios;

  const AnimeDetails({
    this.malId, this.title, this.titleEnglish, this.titleJapanese,
    this.images, this.type, this.source, this.episodes, this.status,
    this.airing, this.aired, this.duration, this.rating, this.score,
    this.scoredBy, this.rank, this.popularity, this.members, this.favorites,
    this.synopsis, this.background, this.season, this.year, this.genres,
    this.studios,
  });

  factory AnimeDetails.fromJson(Map<String, dynamic> json) {
    return AnimeDetails(
      malId: _parseInt(json['mal_id']),
      title: json['title'] as String?,
      titleEnglish: json['title_english'] as String?,
      titleJapanese: json['title_japanese'] as String?,
      images: json['images'],
      type: json['type'] as String?,
      source: json['source'] as String?,
      episodes: _parseInt(json['episodes']),
      status: json['status'] as String?,
      airing: json['airing'] as bool?,
      aired: json['aired'],
      duration: json['duration'] as String?,
      rating: json['rating'] as String?,
      score: _parseDouble(json['score']),
      scoredBy: _parseInt(json['scored_by']),
      rank: _parseInt(json['rank']),
      popularity: _parseInt(json['popularity']),
      members: _parseInt(json['members']),
      favorites: _parseInt(json['favorites']),
      synopsis: json['synopsis'] as String?,
      background: json['background'] as String?,
      season: json['season'] as String?,
      year: _parseInt(json['year']),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      studios: json['studios'] as List<dynamic>?,
    );
  }

  static int? _parseInt(dynamic v) => v == null ? null : (v is num ? v.toInt() : (v is String ? int.tryParse(v) : null));
  static double? _parseDouble(dynamic v) => v == null ? null : (v is num ? v.toDouble() : (v is String ? double.tryParse(v) : null));

  Map<String, dynamic> toJson() => {
    'mal_id': malId, 'title': title, 'title_english': titleEnglish,
    'title_japanese': titleJapanese, 'images': images, 'type': type,
    'source': source, 'episodes': episodes, 'status': status,
    'airing': airing, 'aired': aired, 'duration': duration,
    'rating': rating, 'score': score, 'scored_by': scoredBy,
    'rank': rank, 'popularity': popularity, 'members': members,
    'favorites': favorites, 'synopsis': synopsis, 'background': background,
    'season': season, 'year': year,
    'genres': genres?.map((e) => e.toJson()).toList(), 'studios': studios,
  };

  String get imageUrl {
    if (images is Map<String, dynamic>) {
      final jpg = images['jpg'] as Map<String, dynamic>?;
      if (jpg != null) return jpg['large_image_url'] ?? jpg['image_url'] ?? '';
    }
    return '';
  }

  String get backdropUrl => imageUrl;

  String get displayTitle => titleEnglish ?? title ?? '';
}
