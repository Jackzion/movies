import 'package:flutter/material.dart';

Widget addVerticalSpace(double amount) {
  return SizedBox(height: amount);
}

Widget addHorizontalSpace(double amount) {
  return SizedBox(width: amount);
}

typedef OnMovieTap = void Function(int movieId);

String youtubeUrlFromId(String videoId) {
return 'https://www.youtube.com/watch?v=$videoId';
}

enum Sorting {
  aToz(name: 'A-Z'),
  zToa(name: 'Z-A'),
  rating(name: 'Rating'),
  year(name: 'Year');

  const Sorting({required this.name});
  final String name;
}
