import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/database/models/database_models.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/screens/genres/sort_picker.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/vert_favorite_list.dart';
import 'package:movies/ui/widgets/not_ready.dart';
import 'package:movies/utils/utils.dart';

/// 收藏页面
/// 展示用户收藏的动漫列表，支持排序和收藏状态更新
@RoutePage(name: 'FavoriteRoute')
class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  late AnimeViewModel animeViewModel;
  List<DBFavorite> currentFavorites = [];
  Sorting selectedSort = Sorting.aToz;

  @override
  Widget build(BuildContext context) {
    final animeViewModelAsync = ref.watch(animeViewModelProvider);
    return animeViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        animeViewModel = viewModel;
        return buildScreen();
      },
    );
  }

  Widget buildScreen() {
    return SafeArea(
      child: StreamBuilder<List<DBFavorite>>(
        stream: getFavoriteStream(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState != ConnectionState.active) &&
              (snapshot.connectionState != ConnectionState.done)) {
            return const NotReady();
          }
          currentFavorites = sortFavorites(snapshot.requireData);
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
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16.0, 0.0, 24.0),
                                child: Text(
                                  'My Favorites',
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SortPicker(
                          selectedSort: selectedSort,
                          useSliver: true,
                          onSortSelected: (sorting) {
                            setState(() {
                              selectedSort = sorting;
                            });
                          },
                        ),
                        VerticalFavoriteList(
                          favorites: currentFavorites,
                          animeViewModel: animeViewModel,
                          onAnimeTap: (animeId) {
                            context.router
                                .push(AnimeDetailRoute(animeId: animeId));
                          },
                          onFavoritesTap: (DBFavorite favorite) {
                            removeFavorite(favorite);
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

  Stream<List<DBFavorite>> getFavoriteStream() {
    return animeViewModel.streamFavorites();
  }

  List<DBFavorite> sortFavorites(List<DBFavorite> source) {
    return source.sorted((a, b) {
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
  }

  /// 移除收藏
  Future removeFavorite(DBFavorite favorite) async {
    await animeViewModel.removeFavorite(favorite.id);
    setState(() {});
  }
}
