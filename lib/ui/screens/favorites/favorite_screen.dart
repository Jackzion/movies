import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/favorite.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/ui/screens/genres/sort_picker.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/vert_favorite_list.dart';
import 'package:movies/ui/widgets/not_ready.dart';
import 'package:movies/utils/utils.dart';

/// 收藏页面
/// 展示用户收藏的电影列表，支持排序和收藏状态更新
@RoutePage(name: 'FavoriteRoute')
class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  late MovieViewModel movieViewModel;
  List<Favorite> currentFavorites = [];
  Sorting selectedSort = Sorting.aToz;
  final valueNotifier = ValueNotifier<List<Favorite>>([]);

  @override
  Widget build(BuildContext context) {
    // 监听异步提供者状态
    final movieViewModelAsync = ref.watch(movieViewModelProvider);
    return movieViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        movieViewModel = viewModel;
        return buildScreen();
      },
    );
  }

  Widget buildScreen() {
    return SafeArea(
      child: StreamBuilder<List<Favorite>>(
        stream: getFavoriteStream(),
        builder: (context, snapshot) {
          // 检查流是否已加载完成
          if ((snapshot.connectionState != ConnectionState.active) &&
              (snapshot.connectionState != ConnectionState.done)) {
            return const NotReady();
          }
          return Scaffold(
            body: Container(
              color: screenBackground,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        // 标题
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16.0, 0.0, 24.0),
                                child: Text(
                                  'My Favorites',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 排序选择器
                        SortPicker(
                          selectedSort: selectedSort,
                          useSliver: true,
                          onSortSelected: (sorting) {
                            selectedSort = sorting;
                            sortMovies();
                          },
                        ),
                        // 收藏电影列表
                        VerticalFavoriteList(
                          favorites: snapshot.requireData,
                          movieViewModel: movieViewModel,
                          onMovieTap: (movieId) {
                            context.router.push(MovieDetailRoute(movieId: movieId));
                          },
                          onFavoritesTap: (Favorite favorite) {
                            setState(() {
                              // 切换收藏状态
                              favorite.favorite = !favorite.favorite;
                              movieViewModel.updateFavorite(favorite);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 获取收藏电影流
  Stream<List<Favorite>> getFavoriteStream() {
    return movieViewModel.streamFavorites();
  }

  /// 对收藏电影列表进行排序
  void sortMovies() {
    if (currentFavorites.isEmpty) {
      return;
    }
    currentFavorites = currentFavorites.sorted((a, b) {
      switch (selectedSort) {
        case Sorting.aToz:
          return a.title.compareTo(b.title);
        case Sorting.zToa:
          return b.title.compareTo(a.title);
        case Sorting.rating:
          return b.popularity.compareTo(a.popularity);
        case Sorting.year:
          return a.releaseDate.compareTo(b.releaseDate);
      }
    });
    valueNotifier.value = currentFavorites;
  }

  /// 移除收藏
  Future removeFavorite(Favorite favorite) async {
    setState(() {
      currentFavorites.removeWhere((fav) => fav.movieId == favorite.movieId);
      valueNotifier.value = currentFavorites;
    });
  }
}
