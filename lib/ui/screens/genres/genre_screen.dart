import 'package:auto_route/auto_route.dart';
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
import 'package:movies/utils/utils.dart';

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
  final searchTextNotifier = ValueNotifier<String>('');
  List<Anime> currentAnimeList = [];
  Sorting selectedSort = Sorting.aToz;

  /// 类型列表是否已初始化（避免每次 build 清空重建）
  bool _genreStateReady = false;

  @override
  void dispose() {
    searchTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animeViewModelAsync = ref.watch(animeViewModelProvider);
    return animeViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        animeViewModel = viewModel;
        ensureGenreState();
        return buildScreen();
      },
    );
  }

  /// 仅在首次拿到类型数据时初始化，后续 rebuild 不再 clear
  void ensureGenreState() {
    if (_genreStateReady) {
      return;
    }
    final genres = animeViewModel.animeGenres;
    if (genres == null || genres.isEmpty) {
      return;
    }
    genreStates = [
      for (final genre in genres)
        GenreState(genre: genre, isSelected: false),
    ];
    _genreStateReady = true;
    // 异步恢复本地选中项
    restoreSelectedGenres();
  }

  /// 从本地存储恢复选中状态（只改 isSelected，不重建列表）
  Future<void> restoreSelectedGenres() async {
    final prefs = await ref.read(prefsProvider.future);
    final raw = prefs.getString(genreStringKey);
    if (raw == null || raw.isEmpty) {
      return;
    }
    final selectedNames = raw.split(',').where((s) => s.isNotEmpty).toSet();
    if (!mounted || selectedNames.isEmpty) {
      return;
    }
    setState(() {
      genreStates = [
        for (final state in genreStates)
          state.copyWith(isSelected: selectedNames.contains(state.genre.name)),
      ];
    });
  }

  /// 仅保存已选中的类型名
  Future<void> saveSelectedGenres() async {
    final prefs = await ref.read(prefsProvider.future);
    final selectedNames = genreStates
        .where((state) => state.isSelected)
        .map((state) => state.genre.name)
        .toList();
    prefs.setString(genreStringKey, selectedNames.join(','));
  }

  Widget buildScreen() {
    // SearchDialog / 菜单写入 searchTextProvider 时同步并触发搜索
    final searchText = ref.watch(searchTextProvider);
    if (searchText != searchTextNotifier.value) {
      searchTextNotifier.value = searchText;
      currentAnimeList = [];
      expandedNotifier.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        search();
      });
    }
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
                          // 只收起类型区，不清空类型数据
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
                        onGenresSelected: (fullList) {
                          // 保持全量列表，只同步选中状态
                          genreStates = fullList;
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

  void search() async {
    final selectedTags = genreStates
        .where((state) => state.isSelected)
        .map((state) => state.genre.name)
        .toList();
    final animeList = await animeViewModel.searchAnimes(
      currentSearchString,
      1,
      selectedTags.isEmpty ? null : selectedTags,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      currentAnimeList = animeList ?? [];
      expandedNotifier.value = true;
    });
  }
}

/// 类型展开状态通知器
final ValueNotifier<bool> expandedNotifier = ValueNotifier<bool>(true);
