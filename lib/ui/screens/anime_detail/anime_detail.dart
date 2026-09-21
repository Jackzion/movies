import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/screens/anime_detail/button_row.dart';
import 'package:movies/ui/screens/anime_detail/detail_image.dart';
import 'package:movies/ui/screens/anime_detail/genre_row.dart';
import 'package:movies/ui/screens/anime_detail/anime_overview.dart';
import 'package:movies/ui/screens/anime_detail/trailer.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/horiz_cast.dart';
import 'package:movies/ui/widgets/not_ready.dart';

/// 动漫详情页面
/// 展示动漫的封面图、类型、简介、收藏按钮和预告片列表
@RoutePage(name: 'AnimeDetailRoute')
class AnimeDetail extends ConsumerStatefulWidget {
  /// 动漫 ID，用于从动漫列表中获取对应动漫数据
  final int animeId;
  const AnimeDetail(this.animeId, {super.key});

  @override
  ConsumerState<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends ConsumerState<AnimeDetail> {
  late AnimeViewModel animeViewModel;
  List<GenreState> genreStates = [];
  Anime? currentAnime;

  @override
  Widget build(BuildContext context) {
    // 监听异步提供者状态
    final animeViewModelAsync = ref.watch(animeViewModelProvider);
    return animeViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        animeViewModel = viewModel;
        currentAnime = animeViewModel.findAnimeById(widget.animeId);
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
    if (currentAnime == null) {
      return const NotReady();
    }

    final anime = currentAnime!;
    final favoriteNotifier = ValueNotifier<bool>(false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: screenBackground,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              ref.read(appRouterProvider).maybePop();
            },
          ),
          centerTitle: false,
          title: Text(
            'Back',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Container(
          color: screenBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Stack(children: [DetailImage(animeUrl: anime.image)]),
                        GenreRow(genres: genreStates),
                        AnimeOverview(
                          details: anime.synopsis ?? '',
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: favoriteNotifier,
                          builder: (
                            BuildContext context,
                            bool value,
                            Widget? child,
                          ) {
                            return ButtonRow(
                              favoriteSelected: favoriteNotifier.value,
                              onFavoriteSelected: () async {
                                if (favoriteNotifier.value) {
                                  favoriteNotifier.value = false;
                                } else {
                                  favoriteNotifier.value = true;
                                }
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Text(
                            'Trailers',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Trailer(
                          animeVideos: const ['U2Qp5pL3ovA'],
                          onVideoTap: (video) {
                            debugPrint('Trailer tapped: $video');
                            context.router.push(
                              VideoPageRoute(animeVideo: 'U2Qp5pL3ovA'),
                            );
                          },
                        ),
                      ]),
                    ),
                    HorizontalCast(castList: ['', '']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
