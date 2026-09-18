import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/screens/movie_detail/button_row.dart';
import 'package:movies/ui/screens/movie_detail/detail_image.dart';
import 'package:movies/ui/screens/movie_detail/genre_row.dart';
import 'package:movies/ui/screens/movie_detail/movie_overview.dart';
import 'package:movies/ui/screens/movie_detail/trailer.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/horiz_cast.dart';

@RoutePage(name: 'MovieDetailRoute')
/// 电影详情页面
/// 展示电影的封面图、类型、简介、收藏按钮和预告片列表
class MovieDetail extends ConsumerStatefulWidget {
  /// 电影 ID，用于从电影列表中获取对应电影数据
  final int movieId;
  const MovieDetail(this.movieId, {super.key});

  @override
  ConsumerState<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends ConsumerState<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: 接 genre provider 后改为 ref.watch(genresProvider)
    final genres = ref.read(genresProvider);
    // 从电影图片列表中获取所有电影封面地址
    final movies = ref.read(movieImagesProvider);
    final favoriteNotifier = ValueNotifier<bool>(false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: screenBackground,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              ref.read(appRouterProvider).maybePopTop();
            },
          ),
          centerTitle: false,
          title: Text(
            'Back',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Container(
          color: screenBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        // 根据电影 ID 从列表中获取对应的封面图片地址
                        Stack(children: [DetailImage(movieUrl: movies[widget.movieId])]),
                        GenreRow(genres: genres),
                        MovieOverview(
                          details:
                              'A movie description goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: favoriteNotifier,
                          builder: (
                            BuildContext context,
                            bool value,
                            Widget? child,
                          ) {
                            return ButtonRow(
                              favoriteSelected: favoriteNotifier.value,
                              onFavoriteSelected: () async {
                                if (favoriteNotifier.value) {
                                  favoriteNotifier.value = false;
                                } else {
                                  favoriteNotifier.value = true;
                                }
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Text(
                            'Trailers',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Trailer(
                          movieVideos: const ['U2Qp5pL3ovA'],
                          onVideoTap: (video) {
                            debugPrint('Trailer tapped: $video');
                            // 教程这里其实是 video id,Trailer 内部拼成缩略图 URL
                            context.router.push(
                              VideoPageRoute(movieVideo: 'U2Qp5pL3ovA'),
                            );
                          },
                        ),
                      ]),
                    ),
                    // HorizontalCast 必须是同级 sliver,不能塞进 SliverChildListDelegate
                    HorizontalCast(castList: ['', '']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}