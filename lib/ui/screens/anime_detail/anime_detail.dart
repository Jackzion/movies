import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:movies/data/models/anime_character.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/data/models/anime_extras.dart';
import 'package:movies/data/models/anime_video.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/ui/screens/anime_detail/anime_overview.dart';
import 'package:movies/ui/screens/anime_detail/button_row.dart';
import 'package:movies/ui/screens/anime_detail/detail_banner.dart';
import 'package:movies/ui/screens/anime_detail/detail_image.dart';
import 'package:movies/ui/screens/anime_detail/trailer.dart';
import 'package:movies/ui/widgets/horiz_cast.dart';
import 'package:movies/ui/widgets/not_ready.dart';
import 'package:movies/utils/utils.dart';

/// 动漫详情页面
/// 顶部 bannerImage 渐进色背景；下方左完整 detail.image 海报+元信息，右章节/简介/标签
@RoutePage(name: 'AnimeDetailRoute')
class AnimeDetail extends ConsumerStatefulWidget {
  final int animeId;
  const AnimeDetail(this.animeId, {super.key});

  @override
  ConsumerState<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends ConsumerState<AnimeDetail> {
  late AnimeViewModel animeViewModel;
  AnimeDetails? animeDetails;
  String? bannerImage;
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
          backgroundColor: const Color(0xFF2B2B2B),
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
          color: const Color(0xFF2B2B2B),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  // 顶部渐进色背景：图源 bannerImage（animeId 对应 AniList）
                  DetailBanner(
                    details: details,
                    bannerImage: bannerImage,
                  ),
                  // 左完整 detail.image + 元信息；右章节/简介/标签
                  _buildPosterAndOverview(details),
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
                  if (characters.isNotEmpty) ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 16, top: 16),
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
      ),
    );
  }

  /// 左海报+元信息 / 右简介面板
  /// 宽屏左右分栏；窄屏纵向堆叠，海报仍展示完整封面
  Widget _buildPosterAndOverview(AnimeDetails details) {
    final width = MediaQuery.of(context).size.width;
    // 参考 CSS 在 780px 以下改为纵向
    final isWide = width >= 780;

    final posterAndMeta = _buildPosterColumn(details, isWide: isWide);
    final overview = AnimeOverview(details: details);

    if (!isWide) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: posterAndMeta),
            addVerticalSpace(20),
            overview,
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 12, 40, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== LEFT : 完整 detail.image 海报 + 元信息 =====
          SizedBox(
            width: 240,
            child: posterAndMeta,
          ),
          addHorizontalSpace(28),
          // ===== RIGHT : 章节 / 简介 / 标签 =====
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: overview,
            ),
          ),
        ],
      ),
    );
  }

  /// 左侧列：完整 detail.image 海报 + 中文名 / 话数
  Widget _buildPosterColumn(
    AnimeDetails details, {
    required bool isWide,
  }) {
    final posterWidth = isWide ? 240.0 : 200.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: posterWidth,
          child: DetailImage(details: details, width: posterWidth),
        ),
        addVerticalSpace(16),
        SizedBox(
          width: isWide ? 240 : double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaLine(label: '中文名', value: details.displayTitle),
              if (details.episodes != null) ...[
                addVerticalSpace(8),
                _MetaLine(label: '话数', value: '${details.episodes}'),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadData() async {
    animeDetails = await animeViewModel.getAnimeDetails(widget.animeId);

    // 按 animeId 补充 bannerImage（AniList），与视频/角色并行加载
    String? nameJa;
    String? nameCn;
    final anime = animeViewModel.findAnimeById(widget.animeId);
    if (anime != null) {
      nameJa = anime.titleJapanese;
      nameCn = anime.title;
    } else {
      nameJa = animeDetails?.titleJapanese;
      nameCn = animeDetails?.title;
    }

    final results = await Future.wait([
      animeViewModel.getAnimeVideos(widget.animeId),
      animeViewModel.getAnimeCharacters(widget.animeId),
      animeViewModel.getExtras(widget.animeId, nameJa, nameCn),
    ]);
    videos = results[0] as List<AnimeVideo>;
    characters = results[1] as List<AnimeCharacter>;
    bannerImage = (results[2] as AnimeExtras).bannerImage;
  }
}

/// 元信息行（海报下方）
class _MetaLine extends StatelessWidget {
  final String label;
  final String value;

  const _MetaLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSansSc(
            fontSize: 14,
            height: 1.9,
            color: const Color(0xFFB9B9B9),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.notoSansSc(
              fontSize: 14,
              height: 1.9,
              color: const Color(0xFFB9B9B9),
            ),
          ),
        ),
      ],
    );
  }
}