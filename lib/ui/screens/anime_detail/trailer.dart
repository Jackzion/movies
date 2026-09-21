import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/utils/utils.dart';

/// 动漫预告片列表组件
/// 横向滚动展示预告片缩略图，点击后触发回调
class Trailer extends ConsumerStatefulWidget {
  /// 预告片视频 ID 列表
  final List<String>? animeVideos;
  /// 预告片点击回调
  final OnAnimeVideoTap onVideoTap;
  const Trailer({this.animeVideos, required this.onVideoTap, super.key});

  @override
  ConsumerState<Trailer> createState() => _TrailerState();
}

class _TrailerState extends ConsumerState<Trailer> {
  @override
  Widget build(BuildContext context) {
    // 1
    if (widget.animeVideos == null) {
      return Container();
    }

    // 2
    return SizedBox(
      height: 120,
      // 3
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.animeVideos!.length,
        itemBuilder: (BuildContext context, int index) {
          // 4
          return GestureDetector(
            onTap: () {
              widget.onVideoTap(widget.animeVideos![index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 5
                  CachedNetworkImage(
                    imageUrl:
                        'https://img.youtube.com/vi/${widget.animeVideos![index]}/0.jpg',
                    fit: BoxFit.cover,
                    height: 80,
                    width: 150,
                    // 加载中显示灰底,失败显示摄像机图标占位(大陆环境 YouTube CDN 经常超时)
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
                  // 6
                  SizedBox(
                    width: 150,
                    child: AutoSizeText(
                      'Trailer ${index + 1}',
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
