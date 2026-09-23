import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/data/models/genre_state.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/screens/genres/sort_picker.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/screens/genres/genre_search_row.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/widgets/sliver_divider.dart';
import 'package:movies/ui/widgets/vert_anime_list.dart';
import 'package:movies/ui/widgets/not_ready.dart';

/// 选中类型存储键
const String genreStringKey = 'GenreKey';

/// 类型页面
/// 展示动漫类型列表和对应类型的动漫
/// 支持搜索和类型筛选
@RoutePage(name: 'GenreRoute')
class GenreScreen extends ConsumerStatefulWidget {
  const GenreScreen({super.key});

  @override
  ConsumerState<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends ConsumerState<GenreScreen> {
  late AnimeViewModel animeViewModel;
  List<GenreState> genreStates = [];
  String currentSearchString = '';
  List<Anime> currentAnimeList = [];
  Sorting selectedSort = Sorting.aToz;

  @override
  Widget build(BuildContext context) {
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
    for (final genre in animeViewModel.animeGenres!) {
      genreStates.add(GenreState(genre: genre, isSelected: false));
    }
    // 从本地存储加载已选中的类型
    getSelectedGenres();
  }

  /// 从本地存储加载已选中的类型
  void getSelectedGenres() async {
    final prefs = await ref.read(prefsProvider.future);
    final genreNameList = prefs.getString(genreStringKey)?.split(',');
    if (genreNameList?.isNotEmpty == true) {
      for (final genreName in genreNameList!) {
        var genreState = genreStates.firstWhereOrNull(
          (genre) => genre.genre.name == genreName,
        );
        if (genreState != null) {
          final index = genreStates.indexOf(genreState);
          genreState = genreState.copyWith(isSelected: true);
          genreStates[index] = genreState;
        }
      }
    }
  }

  /// 保存选中的类型到本地存储
  void saveSelectedGenres() async {
    final prefs = await ref.read(prefsProvider.future);
    final genreNameList = genreStates
        .map((state) => state.genre.name)
        .toList();
    prefs.setString(genreStringKey, genreNameList.join(','));
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
                        GenreSearchRow((searchString) {
                          currentSearchString = searchString;
                          FocusScope.of(context).unfocus();
                          expandedNotifier.value = false;
                          search();
                        }),
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
                        onGenresSelected: (genres) {
                          genreStates = genres;
                          saveSelectedGenres();
                        },
                      );
                    },
                  ),
                  const SliverDivider(),
                  SortPicker(
                    selectedSort: selectedSort,
                    onSortSelected: (sorting) {
                      selectedSort = sorting;
                      setState(() {});
                    },
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
