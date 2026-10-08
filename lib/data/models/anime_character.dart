import 'package:movies/data/models/anime_image_configuration.dart';

/// 动漫角色数据模型
/// 数据来源：Bangumi 条目角色（含 CV 声优）
class AnimeCharacter {
  /// 角色信息
  final Character? character;

  /// 角色在动画中的定位（如 主角/配角/客串/其他）
  final String? role;

  /// 声优列表
  final List<VoiceActor>? voiceActors;

  const AnimeCharacter({
    this.character,
    this.role,
    this.voiceActors,
  });

  /// 从 Bangumi 角色条目构造
  factory AnimeCharacter.fromBangumi(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>?;
    return AnimeCharacter(
      character: Character(
        bangumiId: json['id'] as int?,
        name: json['name'] as String?,
        image: AnimeImageConfiguration.builtIn.pick(images),
      ),
      role: json['relation'] as String?,
      voiceActors: (json['actors'] as List<dynamic>?)
          ?.map((e) => VoiceActor.fromBangumi(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 角色信息
class Character {
  /// 角色 ID
  final int? bangumiId;

  /// 角色名称
  final String? name;

  /// 角色图片地址
  final String? image;

  const Character({this.bangumiId, this.name, this.image});

  /// 获取角色头像 URL
  String get imageUrl => image ?? '';
}

/// 声优信息
class VoiceActor {
  /// 声优 ID
  final int? bangumiId;

  /// 声优名称
  final String? name;

  /// 声优图片地址
  final String? image;

  /// 语言（动画条目固定为日语）
  final String? language;

  const VoiceActor({this.bangumiId, this.name, this.image, this.language});

  /// 从 Bangumi 声优条目构造
  factory VoiceActor.fromBangumi(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>?;
    return VoiceActor(
      bangumiId: json['id'] as int?,
      name: json['name'] as String?,
      image: AnimeImageConfiguration.builtIn.pick(images),
      language: '日语',
    );
  }

  /// 获取声优头像 URL
  String get imageUrl => image ?? '';
}
