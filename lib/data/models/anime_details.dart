import 'package:movies/data/models/genre.dart';

/// 动漫详情数据模型
/// 数据来源：Bangumi 条目详情
class AnimeDetails {
  /// Bangumi 条目 ID
  final int bangumiId;

  /// 标题（优先中文名，回退日文原名）
  final String? title;

  /// 日文原名
  final String? titleJapanese;

  /// 封面图地址
  final String image;

  /// 放送形式（TV/剧场版/OVA 等）
  final String? type;

  /// 集数
  final int? episodes;

  /// 评分（0-10）
  final double? score;

  /// 排行（越小越高）
  final int? rank;

  /// 收藏人数合计（想看/在看/看过/搁置/抛弃）
  final int? members;

  /// 简介
  final String? synopsis;

  /// 放送年份
  final int? year;

  /// 标签（取自 Bangumi 标签，用于类型展示）
  final List<Genre>? genres;

  const AnimeDetails({
    required this.bangumiId,
    this.title,
    this.titleJapanese,
    this.image = '',
    this.type,
    this.episodes,
    this.score,
    this.rank,
    this.members,
    this.synopsis,
    this.year,
    this.genres,
  });

  /// 从 Bangumi 条目详情构造
  factory AnimeDetails.fromBangumi(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>?;
    final rating = json['rating'] as Map<String, dynamic>?;
    final collection = json['collection'] as Map<String, dynamic>?;
    final nameCn = json['name_cn'] as String?;
    final name = json['name'] as String?;
    final date = json['date'] as String?;
    return AnimeDetails(
      bangumiId: json['id'] as int? ?? 0,
      title: (nameCn != null && nameCn.isNotEmpty) ? nameCn : name,
      titleJapanese: name,
      image: images?['large'] as String? ?? images?['medium'] as String? ?? '',
      type: json['platform'] as String?,
      episodes: _parseInt(json['eps'] ?? json['total_episodes']),
      score: _parseDouble(rating?['score']),
      rank: _parseInt(rating?['rank']),
      members: _parseCollectionTotal(collection),
      synopsis: json['summary'] as String?,
      year: _parseYear(date),
      genres: _parseGenres(json['tags'] as List<dynamic>?),
    );
  }

  /// 封面图地址
  String get imageUrl => image;

  /// 展示标题（优先中文）
  String get displayTitle => title ?? titleJapanese ?? '';

  /// 从标签中提取类型（跳过年份、放送形式等元标签）
  static List<Genre>? _parseGenres(List<dynamic>? tags) {
    if (tags == null || tags.isEmpty) {
      return null;
    }
    const skip = {'TV', 'OVA', 'OAD', 'WEB', '剧场版', '动态漫画'};
    final genres = <Genre>[];
    for (final tag in tags) {
      if (tag is! Map<String, dynamic>) {
        continue;
      }
      final name = tag['name'] as String? ?? '';
      if (name.isEmpty ||
          skip.contains(name) ||
          RegExp(r'^\d').hasMatch(name)) {
        continue;
      }
      genres.add(Genre(malId: genres.length + 1, name: name));
      if (genres.length >= 6) {
        break;
      }
    }
    return genres.isEmpty ? null : genres;
  }

  static int? _parseCollectionTotal(Map<String, dynamic>? collection) {
    if (collection == null) {
      return null;
    }
    var total = 0;
    var hasValue = false;
    for (final value in collection.values) {
      if (value is num) {
        total += value.toInt();
        hasValue = true;
      }
    }
    return hasValue ? total : null;
  }

  static int? _parseYear(String? date) {
    if (date == null || date.length < 4) {
      return null;
    }
    return int.tryParse(date.substring(0, 4));
  }

  static int? _parseInt(dynamic value) {
    if (value == null) {
      return null;
    }
    return value is num ? value.toInt() : int.tryParse(value.toString());
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    return value is num ? value.toDouble() : double.tryParse(value.toString());
  }
}
