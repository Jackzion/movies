/// 动漫图片配置（对标 TMDB /configuration）
///
/// TMDB 有独立的 configuration 接口下发 base_url 与各图种尺寸列表；
/// Bangumi / AniList 没有等价接口，但响应里带尺寸键，且 Bangumi CDN
/// 支持路径尺寸段（/pic/cover/{l|m|s|c|g}/）与按宽度缩放（/r/{width}/）。
/// 这里把这些约定收成可序列化配置，本地缓存后用来选尺寸、拼 URL，避免硬编码。
class AnimeImageConfiguration {
  /// Bangumi 图片 CDN 主机
  final String bangumiHost;

  /// AniList 图片 CDN 主机
  final String anilistHost;

  /// Bangumi images 对象的尺寸键（按偏好从大到小）
  /// cover: large / medium / common / small / grid
  final List<String> bangumiSizes;

  /// Bangumi 路径尺寸段，与 [bangumiSizes] 同序
  /// large→l, medium→m, common→c, small→s, grid→g
  final List<String> bangumiPathSizes;

  /// Bangumi /r/{width}/ 允许的缩放宽度（仅对 /pic/.../l/ 原图有效）
  final List<int> bangumiResizeWidths;

  /// AniList 封面尺寸键
  /// extraLarge→cover/large, large→cover/medium, medium→cover/small
  final List<String> anilistCoverSizes;

  /// AniList 角色/人物尺寸键
  final List<String> anilistCharacterSizes;

  const AnimeImageConfiguration({
    this.bangumiHost = 'https://lain.bgm.tv',
    this.anilistHost = 'https://s4.anilist.co',
    this.bangumiSizes = const ['large', 'medium', 'common', 'small', 'grid'],
    this.bangumiPathSizes = const ['l', 'm', 'c', 's', 'g'],
    this.bangumiResizeWidths = const [100, 200, 400, 600, 800, 1200],
    this.anilistCoverSizes = const ['extraLarge', 'large', 'medium'],
    this.anilistCharacterSizes = const ['large', 'medium'],
  });

  /// 内置默认配置（已与线上 CDN 约定对齐）
  static const AnimeImageConfiguration builtIn = AnimeImageConfiguration();

  factory AnimeImageConfiguration.fromJson(Map<String, dynamic> json) {
    return AnimeImageConfiguration(
      bangumiHost: json['bangumiHost'] as String? ?? builtIn.bangumiHost,
      anilistHost: json['anilistHost'] as String? ?? builtIn.anilistHost,
      bangumiSizes: _stringList(json['bangumiSizes']) ?? builtIn.bangumiSizes,
      bangumiPathSizes:
          _stringList(json['bangumiPathSizes']) ?? builtIn.bangumiPathSizes,
      bangumiResizeWidths:
          _intList(json['bangumiResizeWidths']) ?? builtIn.bangumiResizeWidths,
      anilistCoverSizes:
          _stringList(json['anilistCoverSizes']) ?? builtIn.anilistCoverSizes,
      anilistCharacterSizes: _stringList(json['anilistCharacterSizes']) ??
          builtIn.anilistCharacterSizes,
    );
  }

  Map<String, dynamic> toJson() => {
        'bangumiHost': bangumiHost,
        'anilistHost': anilistHost,
        'bangumiSizes': bangumiSizes,
        'bangumiPathSizes': bangumiPathSizes,
        'bangumiResizeWidths': bangumiResizeWidths,
        'anilistCoverSizes': anilistCoverSizes,
        'anilistCharacterSizes': anilistCharacterSizes,
      };

  /// 从 Bangumi images 对象按配置偏好挑一张图
  /// [prefer] 可指定尺寸键；缺失时沿偏好列表回退
  String pick(Map<String, dynamic>? images, {String? prefer}) {
    if (images == null || images.isEmpty) return '';
    if (prefer != null) {
      final hit = images[prefer];
      if (hit is String && hit.isNotEmpty) return hit;
    }
    for (final size in bangumiSizes) {
      final url = images[size];
      if (url is String && url.isNotEmpty) return url;
    }
    for (final value in images.values) {
      if (value is String && value.isNotEmpty) return value;
    }
    return '';
  }

  /// 将 Bangumi 图片 URL 重写为指定路径尺寸段（large/medium/...）
  /// 仅改 /pic/.../{size}/ 段；不支持的 URL 原样返回
  String bangumiWithSize(String url, String size) {
    if (url.isEmpty) return url;
    final index = bangumiSizes.indexOf(size);
    if (index < 0 || index >= bangumiPathSizes.length) return url;
    final pathSize = bangumiPathSizes[index];
    return _rewriteBangumiPathSize(url, pathSize);
  }

  /// 将 Bangumi 原图（/pic/.../l/）缩放到 [width]
  /// 仅接受 [bangumiResizeWidths] 中的宽度；其余原样返回
  String bangumiResize(String url, int width) {
    if (url.isEmpty || !bangumiResizeWidths.contains(width)) return url;
    final normalized = _stripBangumiResize(url);
    final hostEnd = normalized.indexOf('/', 'https://'.length);
    if (hostEnd < 0) return url;
    final host = normalized.substring(0, hostEnd);
    final path = normalized.substring(hostEnd);
    if (host != bangumiHost) return url;
    return '$bangumiHost/r/$width$path';
  }

  /// 从任意 Bangumi 图片 URL 推回可缩放的 large 原图地址
  String bangumiLargeSource(String url) {
    if (url.isEmpty) return url;
    final unresized = _stripBangumiResize(url);
    return _rewriteBangumiPathSize(unresized, 'l');
  }

  String _rewriteBangumiPathSize(String url, String pathSize) {
    final unresized = _stripBangumiResize(url);
    // /pic/cover/l/... 或 /pic/crt/l/...
    final match = RegExp(r'(/pic/(?:cover|crt)/)([a-z])(/)').firstMatch(unresized);
    if (match == null) return unresized;
    return unresized.replaceRange(match.start, match.end, '${match[1]}$pathSize/');
  }

  String _stripBangumiResize(String url) {
    return url.replaceFirst(RegExp(r'/r/\d+(?=/pic/)'), '');
  }

  static List<String>? _stringList(dynamic value) {
    if (value is List) {
      return value.whereType<String>().toList();
    }
    return null;
  }

  static List<int>? _intList(dynamic value) {
    if (value is List) {
      return value.whereType<num>().map((e) => e.toInt()).toList();
    }
    return null;
  }
}
