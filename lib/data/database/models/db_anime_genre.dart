/// 类型/标签数据库模型
class DBAnimeGenre {
  /// 本地行 ID
  final int id;

  /// 远端/业务 ID
  final int remoteId;

  /// 标签名
  final String name;

  const DBAnimeGenre({
    required this.id,
    required this.remoteId,
    required this.name,
  });

  factory DBAnimeGenre.fromJson(Map<String, dynamic> json) {
    return DBAnimeGenre(
      id: json['id'] as int? ?? 0,
      remoteId: json['remoteId'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'remoteId': remoteId,
        'name': name,
      };
}
