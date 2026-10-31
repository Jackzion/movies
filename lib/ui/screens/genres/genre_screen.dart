import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart' show listEquals;
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
  List<Anime> currentAnimeList = [];
  String _lastSearchedText = '';
  List<String> _lastSearchedTag = [];
  Sorting selectedSort = Sorting.aToz;

  /// 类型列表是否已初始化（避免每次 build 清空重建）
  bool _genreStateReady = false;

  @override
  void dispose() {
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
      for (final genre in genres) GenreState(genre: genre, isSelected: false),
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

  /// 仅保存已选中的类型名
  void updateSearchTags() {
    final notifier = ref.read(searchTagProvider.notifier);
    final searchTags = List<String>.from(
      ref.read(searchTagProvider.notifier).state,
    );
    // get selected tags
    final selectedNames = genreStates
        .where((state) => state.isSelected)
        .map((state) => state.genre.name)
        .toList();
    // 必须赋一个新列表实例，GenreScreen 的 watch 才能感知变化
    notifier.state = selectedNames;
  }

  Widget buildScreen() {
    // SearchDialog / 菜单 / 全局搜索写入 searchTextProvider 时同步并触发搜索
    final searchText = ref.watch(searchTextProvider);
    // 详情页点标签跳转写入 searchTagProvider，也要带着最新 genres 重新请求
    final searchTag = ref.watch(searchTagProvider);
    final textChanged = searchText != _lastSearchedText;
    // 列表按内容比较（引用比较会每次 rebuild 都判为变化）
    final tagChanged = !listEquals(searchTag, _lastSearchedTag);

    // textChanged ||| tagChanged 才触发 search()
    if (textChanged || tagChanged) {
      _lastSearchedText = searchText; // 只读记忆，没有任何地方会"回写"它
      _lastSearchedTag = List<String>.from(searchTag);
      final hasText = searchText.trim().isNotEmpty;
      final hasTag = searchTag.any((tag) => tag.trim().isNotEmpty);
      // 全局搜索同词双写会经过 ''：中间态不请求、不清列表，避免闪空
      if (!hasText && !hasTag) {
        return SafeArea(child: _genreBody(context));
      }
      currentAnimeList = [];
      expandedNotifier.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        search();
      });
    }
    return SafeArea(child: _genreBody(context));
  }

  Widget _genreBody(BuildContext context) {
    return Container(
      color: screenBackground,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16.0, 0.0, 24.0),
                      child: Text(
                        'Find an Anime',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    GenreSearchRow(ref.watch(searchTextProvider), (
                      searchString,
                    ) {
                      // 只写 provider，其余交给 buildScreen 统一触发
                      ref.read(searchTextProvider.notifier).state =
                          searchString;
                      FocusScope.of(context).unfocus();
                    }),
                  ]),
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
                        // update searchTags provider
                        updateSearchTags();
                        // update prefs
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
    );
  }

  void search() async {
    // 全局搜索双写 '' + keyword 时，空串不要打请求
    final query = ref.read(searchTextProvider).trim();
    // read tag provider（可能有多个，逐个并入）
    final searchTags = ref.read(searchTagProvider);
    final selectedTags = genreStates
        .where((state) => state.isSelected)
        .map((state) => state.genre.name)
        .toList();
    // 搜索 tags 并入最新 genres（已选同名时去重）
    for (final tag in searchTags) {
      if (tag.trim().isNotEmpty && !selectedTags.contains(tag)) {
        selectedTags.add(tag);
      }
    }
    // 关键字与标签都为空时不打请求（支持仅 tag 的搜索）
    if (query.isEmpty && selectedTags.isEmpty) {
      return;
    }
    final animeList = await animeViewModel.searchAnimes(
      query,
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
