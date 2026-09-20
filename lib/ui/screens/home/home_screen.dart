import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';
import 'package:movies/ui/screens/home/title_row.dart';
import 'package:movies/ui/screens/home/horiz_movies.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/movie_widget.dart';
import 'package:movies/ui/widgets/not_ready.dart';

/// 主页
/// 展示轮播图和不同分类的电影列表
@RoutePage(name: 'HomeRoute')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late MovieViewModel movieViewModel;
  Future<List<List<Movie>>>? movieFuture;

  @override
  Widget build(BuildContext context) {
    // 监听异步提供者状态
    final movieViewModelAsync = ref.watch(movieViewModelProvider);
    return movieViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        movieViewModel = viewModel;
        return buildScreen();
      },
    );
  }

  Widget buildScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const NotReady();
          }
          return SingleChildScrollView(
            child: Container(
              color: screenBackground,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'NOW PLAYING',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  HomeScreenImage(
                    movieViewModel: movieViewModel,
                    onMovieTap: onMovieTap,
                  ),
                  TitleRow(text: 'trending ', onMoreClicked: () {}),
                  HorizontalMovies(
                    movies: movieViewModel.trendingMovies,
                    onMovieTap: onMovieTap,
                    movieType: MovieType.trending,
                  ),
                  TitleRow(text: 'popular ', onMoreClicked: () {}),
                  HorizontalMovies(
                    movies: movieViewModel.popularMovies,
                    onMovieTap: onMovieTap,
                    movieType: MovieType.popular,
                  ),
                  TitleRow(text: 'top-rated ', onMoreClicked: () {}),
                  HorizontalMovies(
                    movies: movieViewModel.topRatedMovies,
                    onMovieTap: onMovieTap,
                    movieType: MovieType.topRated,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 加载电影数据
  /// 使用 Future.wait 等待所有分类电影加载完成
  Future<List<List<Movie>>> loadData() async {
    movieFuture ??= Future.wait([
      movieViewModel.getTrendingMovies(1),
      movieViewModel.getTopRated(1),
      movieViewModel.getPopular(1),
      movieViewModel.getNowPlaying(1),
    ]);
    return movieFuture!;
  }

  /// 电影点击回调，跳转到电影详情页
  void onMovieTap(int movieId) {
    context.router.push(MovieDetailRoute(movieId: movieId));
  }
}
