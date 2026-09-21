// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AnimeDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AnimeDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AnimeDetail(
          args.animeId,
          key: args.key,
        ),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteScreen(),
      );
    },
    GenreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GenreScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    VideoPageRoute.name: (routeData) {
      final args = routeData.argsAs<VideoPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VideoPage(
          args.animeVideo,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [AnimeDetail]
class AnimeDetailRoute extends PageRouteInfo<AnimeDetailRouteArgs> {
  AnimeDetailRoute({
    required int animeId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AnimeDetailRoute.name,
          args: AnimeDetailRouteArgs(
            animeId: animeId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AnimeDetailRoute';

  static const PageInfo<AnimeDetailRouteArgs> page =
      PageInfo<AnimeDetailRouteArgs>(name);
}

class AnimeDetailRouteArgs {
  const AnimeDetailRouteArgs({
    required this.animeId,
    this.key,
  });

  final int animeId;

  final Key? key;

  @override
  String toString() {
    return 'AnimeDetailRouteArgs{animeId: $animeId, key: $key}';
  }
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GenreScreen]
class GenreRoute extends PageRouteInfo<void> {
  const GenreRoute({List<PageRouteInfo>? children})
      : super(
          GenreRoute.name,
          initialChildren: children,
        );

  static const String name = 'GenreRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VideoPage]
class VideoPageRoute extends PageRouteInfo<VideoPageRouteArgs> {
  VideoPageRoute({
    required String animeVideo,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          VideoPageRoute.name,
          args: VideoPageRouteArgs(
            animeVideo: animeVideo,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'VideoPageRoute';

  static const PageInfo<VideoPageRouteArgs> page =
      PageInfo<VideoPageRouteArgs>(name);
}

class VideoPageRouteArgs {
  const VideoPageRouteArgs({
    required this.animeVideo,
    this.key,
  });

  final String animeVideo;

  final Key? key;

  @override
  String toString() {
    return 'VideoPageRouteArgs{animeVideo: $animeVideo, key: $key}';
  }
}
