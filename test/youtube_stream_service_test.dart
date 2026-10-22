import 'package:flutter_test/flutter_test.dart';
import 'package:movies/services/video_source/youtube_stream_service.dart';
import 'package:movies/utils/system_proxy.dart';

void main() {
  group('YoutubeStreamService.extractVideoId', () {
    test('纯 ID', () {
      expect(
        YoutubeStreamService.extractVideoId('7rxIZ3z0S4s'),
        '7rxIZ3z0S4s',
      );
    });

    test('watch URL', () {
      expect(
        YoutubeStreamService.extractVideoId(
          'https://www.youtube.com/watch?v=7rxIZ3z0S4s',
        ),
        '7rxIZ3z0S4s',
      );
    });

    test('youtu.be 短链', () {
      expect(
        YoutubeStreamService.extractVideoId('https://youtu.be/7rxIZ3z0S4s'),
        '7rxIZ3z0S4s',
      );
    });

    test('非法输入返回空', () {
      expect(YoutubeStreamService.extractVideoId(''), '');
      expect(YoutubeStreamService.extractVideoId('nope'), '');
      expect(YoutubeStreamService.extractVideoId('https://example.com/watch?v=x'), '');
    });
  });

  group('SystemProxy', () {
    test('findProxy 规则格式', () {
      final rule = SystemProxy.findProxyRule();
      // 要么 DIRECT，要么 PROXY host:port; DIRECT（不要带 http://）
      expect(rule == 'DIRECT' || rule.startsWith('PROXY '), isTrue);
      expect(rule.contains('http://'), isFalse);
    });
  });
}
