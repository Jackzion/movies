import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/screens/genres/sort_picker.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/screens/genres/genre_search_row.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/widgets/sliver_divider.dart';
import 'package:movies/ui/widgets/vert_movie_list.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';

@RoutePage(name: 'GenreRoute')
class GenreScreen extends ConsumerWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.read(genresProvider);
    final movies = ref.watch(movieImagesProvider);
    final genresNotifier = expandedNotifier;
    return SafeArea(
      child: Container(
        color: screenBackground,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // 标题 + 搜索框(两个 box widget 包在 SliverList 里)
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16.0, 0.0, 24.0),
                          child: Text(
                            'Find a Movie',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        GenreSearchRow((searchString) {}),
                      ],
                    ),
                  ),
                  // GenreSection 自己也是 sliver(内部 SliverList 包了 Material)
                  ValueListenableBuilder<bool>(
                    valueListenable: genresNotifier,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return GenreSection(
                        genreStates: genres,
                        isExpanded: value,
                        onGenresExpanded: (expanded) {
                          genresNotifier.value = expanded;
                        },
                        onGenresSelected: (List<GenreState> states) {},
                      );
                    },
                  ),
                  // 分割线用 SliverDivider
                  const SliverDivider(),
                  // SortPicker 用 useSliver: true 时返回 SliverToBoxAdapter
                  SortPicker(
                    selectedSort: Sorting.aToz,
                    onSortSelected: (Sorting sort) {},
                    useSliver: true,
                  ),
                  // VerticalMovieList 自己就是 SliverList
                  VerticalMovieList(
                    movies: movies,
                    onMovieTap: (movieId) {
                      context.router.push(MovieDetailRoute(movieId: movieId));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 把两个 undefined 补上
// expandedNotifier:用一个 ValueNotifier 包 bool,ValueListenableBuilder 会监听它的变化自动重建
final ValueNotifier<bool> expandedNotifier = ValueNotifier<bool>(true);
