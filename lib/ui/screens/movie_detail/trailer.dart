import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/utils/utils.dart';

class Trailer extends ConsumerStatefulWidget {
  final List<String>? movieVideos;
  final OnMovieVideoTap onVideoTap;
  const Trailer({this.movieVideos, required this.onVideoTap, super.key});

  @override
  ConsumerState<Trailer> createState() => _TrailerState();
}

class _TrailerState extends ConsumerState<Trailer> {
  @override
  Widget build(BuildContext context) {
    // 1
    if (widget.movieVideos == null) {
      return Container();
    }

    // 2
    return SizedBox(
      height: 120,
      // 3
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.movieVideos!.length,
        itemBuilder: (BuildContext context, int index) {
          // 4
          return GestureDetector(
            onTap: () {
              widget.onVideoTap(widget.movieVideos![index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 5
                  CachedNetworkImage(
                    imageUrl:
                        'https://img.youtube.com/vi/${widget.movieVideos![index]}/0.jpg',
                    fit: BoxFit.cover,
                    height: 80,
                    width: 150,
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