import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';
import 'package:movies/ui/screens/home/title_row.dart';
import 'package:movies/ui/screens/home/horiz_movies.dart';
import 'package:movies/ui/theme/theme.dart';

@RoutePage(name: 'HomeRoute')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                onMovieTap: (id) {
                  // 直接拿 root AppRouter 实例 push,
                  // 跳过 nested AutoTabsRouter 的 routeCollection 校验
                  ref
                      .read(appRouterProvider)
                      .push(MovieDetailRoute(movieId: id));
                },
              ),
              TitleRow(text: 'trending ', onMoreClicked: () {}),
              const HorizontalMovies(movies: _images),
              TitleRow(text: 'popular ', onMoreClicked: () {}),
              const HorizontalMovies(movies: _images),
              TitleRow(text: 'top-rated ', onMoreClicked: () {}),
              const HorizontalMovies(movies: _images),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> _images = <String>[
  'http://image.tmdb.org/t/p/w780/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg',
  'http://image.tmdb.org/t/p/w780/gKkl37BQuKTanygYQG1pyYgLVgf.jpg',
  'http://image.tmdb.org/t/p/w780/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg',
  'http://image.tmdb.org/t/p/w780/uuA01PTtPombRPvL9dvsBqOBJWm.jpg',
  'http://image.tmdb.org/t/p/w780/H6vke7zGiuLsz4v4RPeReb9rsv.jpg',
  'http://image.tmdb.org/t/p/w780/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg',
  'http://image.tmdb.org/t/p/w780/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg',
  'http://image.tmdb.org/t/p/w780/pKaA8VvfkNfEMUPMiiuL5qSPQYy.jpg',
  'http://image.tmdb.org/t/p/w780/zK2sFxZcelHJRPVr242rxy5VK4T.jpg',
  'http://image.tmdb.org/t/p/w780/7qxG0zyt29BI0IzFDfsps62kbQi.jpg',
];
