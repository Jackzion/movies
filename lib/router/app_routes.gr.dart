// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_routes.dart';

/// generated route for
/// [AnimeDetail]
class AnimeDetailRoute extends PageRouteInfo<AnimeDetailRouteArgs> {
  AnimeDetailRoute({
    required int animeId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         AnimeDetailRoute.name,
         args: AnimeDetailRouteArgs(animeId: animeId, key: key),
         initialChildren: children,
       );

  static const String name = 'AnimeDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnimeDetailRouteArgs>();
      return AnimeDetail(args.animeId, key: args.key);
    },
  );
}

class AnimeDetailRouteArgs {
  const AnimeDetailRouteArgs({required this.animeId, this.key});

  final int animeId;

  final Key? key;

  @override
  String toString() {
    return 'AnimeDetailRouteArgs{animeId: $animeId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AnimeDetailRouteArgs) return false;
    return animeId == other.animeId && key == other.key;
  }

  @override
  int get hashCode => animeId.hashCode ^ key.hashCode;
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
    : super(FavoriteRoute.name, initialChildren: children);

  static const String name = 'FavoriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoriteScreen();
    },
  );
}

/// generated route for
/// [GenreScreen]
class GenreRoute extends PageRouteInfo<void> {
  const GenreRoute({List<PageRouteInfo>? children})
    : super(GenreRoute.name, initialChildren: children);

  static const String name = 'GenreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GenreScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
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
         args: VideoPageRouteArgs(animeVideo: animeVideo, key: key),
         initialChildren: children,
       );

  static const String name = 'VideoPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoPageRouteArgs>();
      return VideoPage(args.animeVideo, key: args.key);
    },
  );
}

class VideoPageRouteArgs {
  const VideoPageRouteArgs({required this.animeVideo, this.key});

  final String animeVideo;

  final Key? key;

  @override
  String toString() {
    return 'VideoPageRouteArgs{animeVideo: $animeVideo, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoPageRouteArgs) return false;
    return animeVideo == other.animeVideo && key == other.key;
  }

  @override
  int get hashCode => animeVideo.hashCode ^ key.hashCode;
}
