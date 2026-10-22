import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies/services/video_source/youtube_stream_service.dart';
import 'package:movies/utils/system_proxy.dart';

/// 实况：youtube_explode 能否解析 YouTube PV 直链
///
/// 运行：flutter test integration_test/youtube_stream_probe_test.dart -d windows
/// 需要能访问 YouTube（系统代理可用）。
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('解析 https://www.youtube.com/watch?v=7rxIZ3z0S4s', (tester) async {
    // ignore: avoid_print
    print('[YT-Resolve] proxy rule → ${SystemProxy.findProxyRule()}');
    // ignore: avoid_print
    print('[YT-Resolve] mpv http-proxy → ${SystemProxy.resolveMpvHttpProxy()}');

    final service = YoutubeStreamService();
    final source = await service.resolve('7rxIZ3z0S4s');
    // ignore: avoid_print
    print('[YT-Resolve] format=${source.format}');
    // ignore: avoid_print
    print('[YT-Resolve] url=${source.url}');

    expect(source.url, isNotEmpty);
    expect(source.url, contains('googlevideo.com'));
  }, timeout: const Timeout(Duration(seconds: 60)));
}
