import 'dart:io';

import 'package:http/io_client.dart';
import 'package:movies/services/video_source/video_source.dart';
import 'package:movies/utils/system_proxy.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// YouTube PV/预告取流服务（youtube_explode）
///
/// 与 [WebviewVideoSourceService] 互补：
/// - webview：正片站（页面内嵌 m3u8/mp4）
/// - 本服务：YouTube（blob/MSE，webview 钩不到 content-type）
///
/// 注意：googlevideo 直链签名绑定出口 IP。若系统开了代理，
/// 解析与后续播放必须走同一条出口（见 [SystemProxy]）。
class YoutubeStreamService {
  /// 从 YouTube videoId（或 watch 短链/完整 URL）解析可播直链。
  ///
  /// 优先 muxed（音画一体，media_kit 可直接播）；无 muxed 时退 HLS。
  Future<VideoSource> resolve(String videoIdOrUrl) async {
    final id = extractVideoId(videoIdOrUrl);
    if (id.isEmpty) {
      throw ArgumentError('不是合法的 YouTube 视频 ID/URL: $videoIdOrUrl');
    }

    final yt = _createClient();
    try {
      final manifest = await yt.videos.streamsClient.getManifest(id);

      if (manifest.muxed.isNotEmpty) {
        final stream = manifest.muxed.withHighestBitrate();
        return VideoSource(stream.url.toString());
      }
      if (manifest.hls.isNotEmpty) {
        return VideoSource(
          manifest.hls.first.url.toString(),
          format: VideoSourceFormat.hls,
        );
      }
      // 没有 muxed/HLS：至少给一条视频流（可能无声）
      if (manifest.videoOnly.isNotEmpty) {
        final stream = manifest.videoOnly.withHighestBitrate();
        return VideoSource(stream.url.toString());
      }
      throw StateError('该视频没有可播的媒体流');
    } finally {
      yt.close();
    }
  }

  /// 解析出 watch URL 给外部浏览器/分享用（不经代理逻辑）。
  static String watchUrl(String videoIdOrUrl) {
    final id = extractVideoId(videoIdOrUrl);
    return id.isEmpty ? videoIdOrUrl : 'https://www.youtube.com/watch?v=$id';
  }

  /// 从 ID / watch URL / youtu.be 提取 videoId。
  static String extractVideoId(String input) {
    final s = input.trim();
    if (s.isEmpty) {
      return '';
    }
    // 已是 11 位 ID
    if (RegExp(r'^[\w-]{11}$').hasMatch(s)) {
      return s;
    }
    final patterns = [
      RegExp(r'(?:v=|/embed/|/shorts/|youtu\.be/)([\w-]{11})'),
      RegExp(r'^([\w-]{11})$'),
    ];
    for (final p in patterns) {
      final m = p.firstMatch(s);
      if (m != null) {
        return m.group(1)!;
      }
    }
    return '';
  }

  YoutubeExplode _createClient() {
    final io = HttpClient()..findProxy = (_) => SystemProxy.findProxyRule();
    return YoutubeExplode(YoutubeHttpClient(IOClient(io)));
  }

  /// 播放侧建议带的请求头（googlevideo 偶发校验 UA）。
  static const Map<String, String> playbackHeaders = {
    'user-agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
            'AppleWebKit/537.36 (KHTML, like Gecko) '
            'Chrome/120.0.0.0 Safari/537.36',
  };
}
