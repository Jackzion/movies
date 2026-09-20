import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/ui/screens/movie_detail/button_row.dart';
import 'package:movies/ui/screens/movie_detail/detail_image.dart';
import 'package:movies/ui/screens/movie_detail/genre_row.dart';
import 'package:movies/ui/screens/movie_detail/movie_overview.dart';
import 'package:movies/ui/screens/movie_detail/trailer.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/horiz_cast.dart';
import 'package:movies/ui/widgets/not_ready.dart';

/// 电影详情页面
/// 展示电影的封面图、类型、简介、收藏按钮和预告片列表
@RoutePage(name: 'MovieDetailRoute')
class MovieDetail extends ConsumerStatefulWidget {
  /// 电影 ID，用于从电影列表中获取对应电影数据
  final int movieId;
  const MovieDetail(this.movieId, {super.key});

  @override
  ConsumerState<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends ConsumerState<MovieDetail> {
  late MovieViewModel movieViewModel;
  List<GenreState> genreStates = [];
  late Movie currentMovie;

  @override
  Widget build(BuildContext context) {
    // 监听异步提供者状态
    final movieViewModelAsync = ref.watch(movieViewModelProvider);
    return movieViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        movieViewModel = viewModel;
        currentMovie = movieViewModel.findMovieById(widget.movieId);
        buildGenreState();
        return buildScreen();
      },
    );
  }

  /// 构建电影类型状态列表
  void buildGenreState() {
    genreStates.clear();
    for (final genre in movieViewModel.movieGenres) {
      genreStates.add(GenreState(genre: genre, isSelected: false));
    }
  }

  Widget buildScreen() {
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
                        Stack(children: [DetailImage(movieUrl: currentMovie.image)]),
                        GenreRow(genres: genreStates),
                        MovieOverview(
                          details: currentMovie.overview,
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
                            context.router.push(
                              VideoPageRoute(movieVideo: 'U2Qp5pL3ovA'),
                            );
                          },
                        ),
                      ]),
                    ),
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
