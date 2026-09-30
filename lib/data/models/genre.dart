import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

/// 类型 / 标签数据模型
@JsonSerializable()
class Genre {
  @JsonKey(name: 'mal_id')
  final int malId;
  final String name;

  /// Bangumi 标签收藏数（可为空）
  final int? count;

  const Genre({required this.malId, required this.name, this.count});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
