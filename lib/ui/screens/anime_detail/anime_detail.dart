import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:movies/data/models/anime_character.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/data/models/anime_video.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/screens/anime_detail/button_row.dart';
import 'package:movies/ui/screens/anime_detail/detail_image.dart';
import 'package:movies/ui/screens/anime_detail/genre_row.dart';
import 'package:movies/ui/screens/anime_detail/anime_overview.dart';
import 'package:movies/ui/screens/anime_detail/trailer.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/horiz_cast.dart';
import 'package:movies/ui/widgets/not_ready.dart';

/// 动漫详情页面
/// 展示动漫的封面图、类型、简介、收藏按钮、预告片和角色列表
@RoutePage(name: 'AnimeDetailRoute')
class AnimeDetail extends ConsumerStatefulWidget {
  /// 动漫 ID
  final int animeId;
  const AnimeDetail(this.animeId, {super.key});

  @override
  ConsumerState<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends ConsumerState<AnimeDetail> {
  late AnimeViewModel animeViewModel;
  AnimeDetails? animeDetails;
  List<AnimeVideo> videos = [];
  List<AnimeCharacter> characters = [];

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
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const NotReady();
        }
        if (snapshot.hasError) {
          logMessage('Error: ${snapshot.error.toString()}');
          return Text(snapshot.error.toString());
        }
        if (animeDetails == null) {
          return const NotReady();
        }
        return buildDetailScreen();
      },
    );
  }

  Widget buildDetailScreen() {
    final details = animeDetails!;
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
                        Stack(children: [DetailImage(details: details)]),
                        GenreRow(genres: details.genres ?? []),
                        AnimeOverview(details: details),
                        ValueListenableBuilder<bool>(
                          valueListenable: favoriteNotifier,
                          builder: (BuildContext context, bool value, Widget? child) {
                            return ButtonRow(
                              favoriteSelected: favoriteNotifier.value,
                              onFavoriteSelected: () {
                                favoriteNotifier.value = !favoriteNotifier.value;
                              },
                            );
                          },
                        ),
                        // 预告片区域
                        if (videos.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Text(
                              'Trailers',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          Trailer(
                            videos: videos,
                            onVideoTap: (video) {
                              context.router.push(
                                VideoPageRoute(animeVideo: video.youtubeId ?? ''),
                              );
                            },
                          ),
                        ],
                        // 角色区域
                        if (characters.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 16, top: 16),
                            child: Text(
                              'Characters',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          HorizontalCast(characters: characters),
                        ],
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadData() async {
    animeDetails = await animeViewModel.getAnimeDetails(widget.animeId);
    // 并行加载视频和角色数据
    final results = await Future.wait([
      animeViewModel.getAnimeVideos(widget.animeId),
      animeViewModel.getAnimeCharacters(widget.animeId),
    ]);
    videos = results[0] as List<AnimeVideo>;
    characters = results[1] as List<AnimeCharacter>;
  }
}
