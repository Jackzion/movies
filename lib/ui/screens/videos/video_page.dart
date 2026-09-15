import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:pod_player/pod_player.dart';
import 'package:movies/utils/utils.dart';

class VideoPage extends ConsumerStatefulWidget {
  final String movieVideo;
  const VideoPage(this.movieVideo, {super.key});
  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late final PodPlayerController podPlayerController;

  @override
  void initState() {
    super.initState();
    // 1
    final playVideoFrom = PlayVideoFrom.youtube(
      youtubeUrlFromId(widget.movieVideo),
    );
    // 2
    podPlayerController = PodPlayerController(
      playVideoFrom: playVideoFrom,
      podPlayerConfig: const PodPlayerConfig(autoPlay: false),
    )..initialise();
  }

  @override
  void dispose() {
    // 3
    podPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoPlayer(context);
  }

  Widget getVideoPlayer(BuildContext context) {
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
            Expanded(
              child: PodVideoPlayer(
                controller: podPlayerController,
                matchVideoAspectRatioToFrame: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
