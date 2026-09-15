import 'package:flutter/material.dart';
import 'package:movies/utils/utils.dart';

import 'movie_row.dart';

import 'package:movies/ui/screens/home/home_screen_image.dart';

typedef OnMovieTap = void Function(int movieId);

class VerticalMovieList extends StatelessWidget {
  final List<String> movies;
  final OnMovieTap onMovieTap;
  const VerticalMovieList({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return MovieRow(movie: movies[index]);
        },
        childCount: movies.length,
      ),
    );
  }
}