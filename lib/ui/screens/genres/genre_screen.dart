import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/screens/genres/sort_picker.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/screens/genres/genre_search_row.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/widgets/sliver_divider.dart';
import 'package:movies/ui/widgets/vert_anime_list.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/ui/widgets/not_ready.dart';

/// 类型页面
/// 展示动漫类型列表和对应类型的动漫
@RoutePage(name: 'GenreRoute')
class GenreScreen extends ConsumerStatefulWidget {
  const GenreScreen({super.key});

  @override
  ConsumerState<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends ConsumerState<GenreScreen> {
  late AnimeViewModel animeViewModel;
  List<GenreState> genreStates = [];
  List<Anime> currentAnimeList = [];

  @override
  Widget build(BuildContext context) {
    // 监听异步提供者状态
    final animeViewModelAsync = ref.watch(animeViewModelProvider);
    return animeViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        animeViewModel = viewModel;
        buildGenreState();
        return buildScreen();
      },
    );
  }

  /// 构建动漫类型状态列表
  void buildGenreState() {
    genreStates.clear();
    for (final genre in animeViewModel.animeGenres) {
      genreStates.add(GenreState(genre: genre, isSelected: false));
    }
  }

  Widget buildScreen() {
    return SafeArea(
      child: Container(
        color: screenBackground,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16.0, 0.0, 24.0),
                          child: Text(
                            'Find an Anime',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        GenreSearchRow((searchString) {}),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: expandedNotifier,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return GenreSection(
                        genreStates: genreStates,
                        isExpanded: value,
                        onGenresExpanded: (expanded) {
                          expandedNotifier.value = expanded;
                        },
                        onGenresSelected: (List<GenreState> states) {},
                      );
                    },
                  ),
                  const SliverDivider(),
                  SortPicker(
                    selectedSort: Sorting.aToz,
                    onSortSelected: (Sorting sort) {},
                    useSliver: true,
                  ),
                  VerticalAnimeList(
                    animes: currentAnimeList,
                    onAnimeTap: (animeId) {
                      context.router.push(AnimeDetailRoute(animeId: animeId));
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

/// 类型展开状态通知器
final ValueNotifier<bool> expandedNotifier = ValueNotifier<bool>(true);
