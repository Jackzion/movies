import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';
import 'package:movies/ui/screens/home/title_row.dart';
import 'package:movies/ui/screens/home/horiz_movies.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/movie_widget.dart';

/// 主页
/// 展示轮播图和不同分类的电影列表
@RoutePage(name: 'HomeRoute')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // 从 provider 获取电影图片列表
    final movies = ref.read(movieImagesProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: SingleChildScrollView(
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
                onMovieTap: onMovieTap,
              ),
              TitleRow(text: 'trending ', onMoreClicked: () {}),
              HorizontalMovies(
                movies: movies,
                onMovieTap: onMovieTap,
                movieType: MovieType.trending,
              ),
              TitleRow(text: 'popular ', onMoreClicked: () {}),
              HorizontalMovies(
                movies: movies,
                onMovieTap: onMovieTap,
                movieType: MovieType.popular,
              ),
              TitleRow(text: 'top-rated ', onMoreClicked: () {}),
              HorizontalMovies(
                movies: movies,
                onMovieTap: onMovieTap,
                movieType: MovieType.topRated,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 电影点击回调，跳转到电影详情页
  void onMovieTap(int movieId) {
    context.router.push(MovieDetailRoute(movieId: movieId));
  }
}
