import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/screens/movie_detail/detail_image.dart';
import 'package:movies/ui/screens/movie_detail/genre_row.dart';
import 'package:movies/ui/screens/movie_detail/movie_overview.dart';
import 'package:movies/ui/theme/theme.dart';

@RoutePage(name: 'MovieDetailRoute')
class MovieDetail extends ConsumerStatefulWidget {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: screenBackground,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              context.router.maybePopTop();
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
                        Stack(children: [DetailImage()]),
                        GenreRow(genres: genres),
                        MovieOverview(
                          details:
                              'A movie description goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        ),
                      ]),
                    ),
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