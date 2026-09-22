import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/models/anime_video.dart';
import 'package:movies/utils/utils.dart';

/// 动漫预告片列表组件
/// 横向滚动展示预告片缩略图，点击后触发回调
class Trailer extends StatelessWidget {
  /// 预告片视频列表
  final List<AnimeVideo> videos;
  /// 预告片点击回调
  final OnAnimeVideoTap onVideoTap;

  const Trailer({required this.videos, required this.onVideoTap, super.key});

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) {
          final video = videos[index];
          return GestureDetector(
            onTap: () => onVideoTap(video),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: video.thumbnailUrl,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 150,
                    placeholder: (context, url) => Container(
                      height: 80,
                      width: 150,
                      color: Colors.grey.shade800,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 80,
                      width: 150,
                      color: Colors.grey.shade800,
                      child: const Icon(
                        Icons.movie_creation_outlined,
                        color: Colors.white54,
                        size: 32,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: AutoSizeText(
                      video.title ?? 'Trailer ${index + 1}',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
