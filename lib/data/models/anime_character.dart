/// 动漫角色数据模型
/// Jikan API 返回的角色和声优信息
class AnimeCharacter {
  /// 角色信息
  final Character? character;

  /// 角色在动画中的角色类型（如 Main, Supporting）
  final String? role;

  /// 声优列表
  final List<VoiceActor>? voiceActors;

  const AnimeCharacter({
    this.character,
    this.role,
    this.voiceActors,
  });

  factory AnimeCharacter.fromJson(Map<String, dynamic> json) {
    return AnimeCharacter(
      character: json['character'] != null
          ? Character.fromJson(json['character'] as Map<String, dynamic>)
          : null,
      role: json['role'] as String?,
      voiceActors: (json['voice_actors'] as List<dynamic>?)
          ?.map((e) => VoiceActor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 角色信息
class Character {
  /// 角色 ID
  final int? malId;

  /// 角色名称
  final String? name;

  /// 角色图片
  final dynamic images;

  const Character({this.malId, this.name, this.images});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      malId: json['mal_id'] as int?,
      name: json['name'] as String?,
      images: json['images'],
    );
  }

  /// 获取角色头像 URL
  String get imageUrl {
    if (images is Map<String, dynamic>) {
      final jpg = images['jpg'] as Map<String, dynamic>?;
      if (jpg != null) {
        return jpg['image_url'] ?? '';
      }
    }
    return '';
  }
}

/// 声优信息
class VoiceActor {
  /// 声优 ID
  final int? malId;

  /// 声优名称
  final String? name;

  /// 声优图片
  final dynamic images;

  /// 语言
  final String? language;

  const VoiceActor({this.malId, this.name, this.images, this.language});

  factory VoiceActor.fromJson(Map<String, dynamic> json) {
    return VoiceActor(
      malId: json['mal_id'] as int?,
      name: json['name'] as String?,
      images: json['images'],
      language: json['language'] as String?,
    );
  }

  /// 获取声优头像 URL
  String get imageUrl {
    if (images is Map<String, dynamic>) {
      final jpg = images['jpg'] as Map<String, dynamic>?;
      if (jpg != null) {
        return jpg['image_url'] ?? '';
      }
    }
    return '';
  }
}
