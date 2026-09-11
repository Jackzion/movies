import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/ui/screens/genres/sort_picker.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/screens/genres/genre_search_row.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/widgets/vert_movie_list.dart';
import 'package:movies/utils/utils.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        color: screenBackground,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16.0, 0.0, 24.0),
                  child: Text(
                    'Find a Movie',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(child: GenreSearchRow((searchString) {})),
              ],
            ),

            // 用 AnimatedSize 替代 ExpansionPanelList,直接展开,
            // 不需要任何外层高度包裹
            ValueListenableBuilder<bool>(
              valueListenable: expandedNotifier,
              builder: (BuildContext context, bool value, Widget? child) {
                return GenreSection(
                  genreStates: genres,
                  isExpanded: value,
                  onGenresExpanded: (expanded) {
                    expandedNotifier.value = expanded;
                  },
                  onGenresSelected: (List<GenreState> states) {},
                );
              },
            ),

            const Spacer(),
            const Divider(),
            SortPicker(selectedSort: Sorting.aToz, onSortSelected: (Sorting sort) {}),
            VerticalMovieList(movies: [], onMovieTap: (movieId) {}),
          ],
        ),
      ),
    );
  }
}

// 把两个 undefined 补上
// expandedNotifier:用一个 ValueNotifier 包 bool,ValueListenableBuilder 会监听它的变化自动重建
final ValueNotifier<bool> expandedNotifier = ValueNotifier<bool>(true);

// genres:假数据,后面接真实 API 时换成从 provider 读
final List<GenreState> genres = <GenreState>[
  GenreState(genre: 'Action', isSelected: false),
  GenreState(genre: 'Adventure', isSelected: false),
  GenreState(genre: 'Animation', isSelected: false),
  GenreState(genre: 'Comedy', isSelected: false),
  GenreState(genre: 'Crime', isSelected: false),
  GenreState(genre: 'Documentary', isSelected: false),
  GenreState(genre: 'Drama', isSelected: false),
  GenreState(genre: 'Family', isSelected: false),
  GenreState(genre: 'Fantasy', isSelected: false),
  GenreState(genre: 'History', isSelected: false),
  GenreState(genre: 'Horror', isSelected: false),
  GenreState(genre: 'Music', isSelected: false),
  GenreState(genre: 'Mystery', isSelected: false),
  GenreState(genre: 'Romance', isSelected: false),
  GenreState(genre: 'Sci-Fi', isSelected: false),
  GenreState(genre: 'Thriller', isSelected: false),
  GenreState(genre: 'War', isSelected: false),
  GenreState(genre: 'Western', isSelected: false),
];
