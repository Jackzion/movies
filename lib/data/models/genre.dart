import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

/// 类型数据模型
@JsonSerializable()
class Genre {
  @JsonKey(name: 'mal_id')
  final int malId;
  final String name;

  const Genre({required this.malId, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
