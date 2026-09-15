import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPage extends ConsumerStatefulWidget {
  final String movieVideo;
  const VideoPage(this.movieVideo, {super.key});
  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late final Player player;
  late final VideoController controller;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: screenBackground,
        leading: BackButton(color: Colors.white, onPressed: () {}),
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