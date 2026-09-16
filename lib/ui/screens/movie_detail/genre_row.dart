import 'package:flutter/material.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/theme/theme.dart';

class GenreRow extends StatelessWidget {
  final List<GenreState> genres;
  const GenreRow({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SizedBox(
        height: 40,
        child: ListView(
          // a. 横向滚动
          scrollDirection: Axis.horizontal,
          children: genres.map((genre) {
            // b. 用 map 生成 widget list,最后 toList()
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                // c. 灰色圆角背景
                decoration: BoxDecoration(
                  color: searchBarBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                // d. 显示 genre 名
                child: Center(
                  child: Text(
                    genre.genre,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}