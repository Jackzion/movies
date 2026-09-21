import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

/// 类型数据模型
/// Jikan API 返回的动漫类型信息
@JsonSerializable()
class Genre {
  /// 类型 ID
  final int malId;

  /// 类型名称
  final String name;

  const Genre({
    required this.malId,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
