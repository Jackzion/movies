import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/services/video_source/video_source.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

/// 视频播放页面
/// 使用 media_kit 播放预告片视频，支持播放控制
@RoutePage(name: 'VideoPageRoute')
class VideoPage extends ConsumerStatefulWidget {
  /// 视频 ID 或播放地址
  final String animeVideo;
  const VideoPage(this.animeVideo, {super.key});
  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late final Player player;
  late final VideoController controller;

  /// 浏览器打开番剧站某一集的播放页，复制地址栏整段 URL 粘到这里。
  /// 注意：必须是「分集播放页」，不是首页/详情页。
  static const String _testPageUrl =
      'https://www.agedm.io/play/20260322/2/1';

  /// 解析中标志：避免连点，也方便看按钮状态
  bool _parsing = false;

  @override
  void initState() {
    super.initState();
    // 直接用 media_kit,Windows desktop 上最稳的视频方案
    // (pod_player 就是包了一层 media_kit,直接用更可控)
    player = Player();
    controller = VideoController(player);

    // 接住播放错误,避免卡死 UI
    player.stream.error.listen((String error) {
      debugPrint('Player error: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('视频错误: $error')),
        );
      }
    });

    // 临时用 .mp4 直链测,先验证 media_kit 在 Windows desktop 上能跑
    // (bee.mp4 是 Flutter 官方测试视频)
    player.open(
      Media(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  /// ===== Phase 1 临时调试：无头 WebView 取流 =====
  /// 点击后：分集页 URL → HeadlessWebview 钓 m3u8/mp4 → 控制台打印直链
  Future<void> _debugParseVideoSource() async {
    if (_parsing) return;
    setState(() => _parsing = true);

    // SnackBar 的 context 在 await 之后可能失效，先把 messenger 拿在手里
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('开始解析（最多等 10 秒）…')),
    );

    try {
      final service = ref.read(webviewVideoSourceServiceProvider);
      final source = await service.parseVideoSource(_testPageUrl);

      // 成功：直链打到 Debug Console / 终端
      debugPrint('[Phase1] resolved => ${source.url} (${source.format})');
      messenger.showSnackBar(
        const SnackBar(content: Text('拿到直链！详见 Run/Debug Console')),
      );

      // 可选：解析成功后直接丢给 media_kit 试播
      // （确认直链能播的话，把下面注释去掉）
      player.open(Media(source.url));
    } on VideoSourceTimeoutException catch (e) {
      // 超时：用户可感知的失败
      debugPrint('[Phase1] timeout: $e');
      messenger.showSnackBar(SnackBar(content: Text('解析超时：$e')));
    } on VideoSourceCanceledException {
      // 被取消（连点/换任务）：静默，不打扰用户
      debugPrint('[Phase1] cancelled (正常)');
    } catch (e) {
      // 其它错误：站点改版、网络失败、WebView 未就绪等
      debugPrint('[Phase1] error: $e');
      messenger.showSnackBar(SnackBar(content: Text('解析失败：$e')));
    } finally {
      if (mounted) {
        setState(() => _parsing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: screenBackground,
        // 教程这里写的是空函数 () {},按下没反应。改成 maybePop 真正返回上一页
          leading: BackButton(
            color: Colors.white,
            onPressed: () => context.router.maybePop(),
          ),
        centerTitle: false,
        title: Text('Back', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: screenBackground,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ===== Phase 1 临时调试按钮（验收完可整段删除）=====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _parsing ? null : _debugParseVideoSource,
                  icon: _parsing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.travel_explore),
                  label: Text(_parsing ? '解析中…' : 'Phase1 测试取流'),
                ),
              ),
            ),
            // ===== 临时调试结束 =====

            // 视频渲染区:Video widget + VideoController
            Expanded(
              child: Video(
                controller: controller,
                fit: BoxFit.contain,
                // 自带 Material 风格控件(播放/暂停/进度条)
                controls: (VideoState state) {
                  return MaterialVideoControls(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
