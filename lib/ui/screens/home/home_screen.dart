import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';
import 'package:movies/ui/screens/home/title_row.dart';
import 'package:movies/ui/screens/home/horiz_animes.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/anime_widget.dart';
import 'package:movies/ui/widgets/not_ready.dart';

/// 主页
/// 展示轮播图和不同分类的动漫列表
@RoutePage(name: 'HomeRoute')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late AnimeViewModel animeViewModel;
  Future<List<List<Anime>>>? animeFuture;

  @override
  Widget build(BuildContext context) {
    // 监听异步提供者状态
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const NotReady();
          }
          return SingleChildScrollView(
            child: Container(
              color: screenBackground,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'NOW PLAYING',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  HomeScreenImage(
                    animeViewModel: animeViewModel,
                    onAnimeTap: onAnimeTap,
                  ),
                  TitleRow(text: 'trending ', onMoreClicked: () {}),
                  HorizontalAnimes(
                    animes: animeViewModel.trendingAnimes,
                    onAnimeTap: onAnimeTap,
                    animeType: AnimeType.trending,
                  ),
                  TitleRow(text: 'popular ', onMoreClicked: () {}),
                  HorizontalAnimes(
                    animes: animeViewModel.popularAnimes,
                    onAnimeTap: onAnimeTap,
                    animeType: AnimeType.popular,
                  ),
                  TitleRow(text: 'top-rated ', onMoreClicked: () {}),
                  HorizontalAnimes(
                    animes: animeViewModel.topRatedAnimes,
                    onAnimeTap: onAnimeTap,
                    animeType: AnimeType.topRated,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 加载动漫数据
  /// 使用 Future.wait 等待所有分类动漫加载完成
  Future<List<List<Anime>>> loadData() async {
    animeFuture ??= Future.wait([
      animeViewModel.getTrendingAnimes(1),
      animeViewModel.getTopRated(1),
      animeViewModel.getPopular(1),
      animeViewModel.getNowPlaying(1),
    ]);
    return animeFuture!;
  }

  /// 动漫点击回调，跳转到动漫详情页
  void onAnimeTap(int animeId) {
    context.router.push(AnimeDetailRoute(animeId: animeId));
  }
}
