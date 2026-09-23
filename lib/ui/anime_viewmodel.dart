import 'package:lumberdash/lumberdash.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/data/models/anime_character.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/data/models/anime_response.dart';
import 'package:movies/data/models/anime_video.dart';
import 'package:movies/data/models/favorite.dart';
import 'package:movies/network/anime_api_service.dart';

/// 动漫视图模型
/// 负责管理动漫数据的加载和分类
/// 从 Jikan API 获取真实动漫数据
class AnimeViewModel {
  /// 动漫 API 服务
  final AnimeAPIService animeAPIService;

  /// 动漫类型列表
  late List<String> animeGenres;

  /// 热门动漫列表
  List<Anime> trendingAnimes = [];

  /// 评分最高的动漫列表
  List<Anime> topRatedAnimes = [];

  /// 最受欢迎的动漫列表
  List<Anime> popularAnimes = [];

  /// 正在播出的动漫列表
  List<Anime> nowPlayingAnimes = [];

  /// 收藏动漫流
  Stream<List<Favorite>>? favoriteStream;

  /// 收藏动漫列表
  List<Favorite>? favoriteList;

  /// 构造函数
  AnimeViewModel({required this.animeAPIService});

  /// 初始化视图模型
  Future<void> setup() async {
    await Future.wait([
      setupGenres(),
    ]);
  }

  /// 加载动漫类型列表
  Future<void> setupGenres() async {
    animeGenres = [
      'Action',
      'Adventure',
      'Comedy',
      'Drama',
      'Fantasy',
      'Horror',
      'Mystery',
      'Romance',
      'Sci-Fi',
      'Slice of Life',
      'Sports',
      'Supernatural',
      'Thriller',
    ];
  }

  /// 获取热门动漫列表
  Future<List<Anime>?> getTrendingAnimes(int page) async {
    try {
      final response = await animeAPIService.getTopAnime(page: page, limit: 10);
      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        trendingAnimes = animeResponse.data;
        return trendingAnimes;
      } else {
        logError('Failed to load trending anime: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      logError('Error loading trending anime: $e');
      return null;
    }
  }

  /// 获取评分最高的动漫列表
  Future<List<Anime>?> getTopRated(int page) async {
    try {
      final response = await animeAPIService.getTopAnime(page: page, limit: 10);
      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        topRatedAnimes = animeResponse.data;
        return topRatedAnimes;
      } else {
        logError('Failed to load top rated anime: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      logError('Error loading top rated anime: $e');
      return null;
    }
  }

  /// 获取最受欢迎的动漫列表
  Future<List<Anime>?> getPopular(int page) async {
    try {
      final response = await animeAPIService.getTopAnime(page: page, limit: 10);
      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        popularAnimes = animeResponse.data;
        return popularAnimes;
      } else {
        logError('Failed to load popular anime: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      logError('Error loading popular anime: $e');
      return null;
    }
  }

  /// 获取正在播出的动漫列表
  Future<List<Anime>?> getNowPlaying(int page) async {
    try {
      final response = await animeAPIService.getSeasonNow(page: page, limit: 10);
      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        nowPlayingAnimes = animeResponse.data;
        return nowPlayingAnimes;
      } else {
        logError('Failed to load now playing anime: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      logError('Error loading now playing anime: $e');
      return null;
    }
  }

  /// 根据动漫 ID 查找动漫
  Anime? findAnimeById(int animeId) {
    // 先在已加载的列表中查找
    for (final list in [trendingAnimes, topRatedAnimes, popularAnimes, nowPlayingAnimes]) {
      for (final anime in list) {
        if (anime.malId == animeId) {
          return anime;
        }
      }
    }
    return null;
  }

  /// 创建收藏动漫流
  Stream<List<Favorite>> streamFavorites() {
    if (favoriteList == null) {
      favoriteList = [];
    }
    favoriteStream = Stream.value(favoriteList!);
    return favoriteStream!;
  }

  /// 更新收藏动漫状态
  void updateFavorite(Favorite favorite) {
    final index = favoriteList!
        .indexWhere((favItem) => favItem.animeId == favorite.animeId);
    if (index != -1) {
      favoriteList![index] = favorite;
    }
  }

  /// 获取动漫详情
  Future<AnimeDetails?> getAnimeDetails(int animeId) async {
    try {
      final response = await animeAPIService.getAnimeDetails(animeId);
      if (response.statusCode == 200) {
        try {
          final data = response.data;
          if (data is! Map<String, dynamic>) {
            logError('Invalid response type: ${data.runtimeType}');
            return null;
          }
          final animeData = data['data'];
          if (animeData is! Map<String, dynamic>) {
            logError('Invalid data type: ${animeData.runtimeType}');
            return null;
          }
          return AnimeDetails.fromJson(animeData);
        } catch (e) {
          logError('Failed to parse anime details: $e');
          return null;
        }
      } else {
        logError('Failed to load anime details: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      logError('Error loading anime details: $e');
      return null;
    }
  }

  /// 获取动漫视频列表（预告片/ED/OP）
  Future<List<AnimeVideo>> getAnimeVideos(int animeId) async {
    try {
      final response = await animeAPIService.getAnimeVideos(animeId);
      if (response.statusCode == 200) {
        try {
          final data = response.data;
          final videoData = data is Map<String, dynamic> ? data['data'] : data;
          if (videoData is Map<String, dynamic>) {
            final promo = videoData['promo'] as List<dynamic>? ?? [];
            return promo
                .map((e) => AnimeVideo.fromJson(e as Map<String, dynamic>))
                .toList();
          }
          return [];
        } catch (e) {
          logError('Failed to parse anime videos: $e');
          return [];
        }
      } else {
        logError('Failed to load anime videos: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      logError('Error loading anime videos: $e');
      return [];
    }
  }

  /// 获取动漫角色和声优列表
  Future<List<AnimeCharacter>> getAnimeCharacters(int animeId) async {
    try {
      final response = await animeAPIService.getAnimeCharacters(animeId);
      if (response.statusCode == 200) {
        try {
          final data = response.data;
          final characterData = data is Map<String, dynamic> ? data['data'] : data;
          if (characterData is List<dynamic>) {
            return characterData
                .map((e) => AnimeCharacter.fromJson(e as Map<String, dynamic>))
                .toList();
          }
          return [];
        } catch (e) {
          logError('Failed to parse anime characters: $e');
          return [];
        }
      } else {
        logError('Failed to load anime characters: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      logError('Error loading anime characters: $e');
      return [];
    }
  }

  /// 搜索动漫
  Future<List<Anime>?> searchAnimes(String query, int page) async {
    try {
      final response = await animeAPIService.searchAnime(query, page: page);
      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        return animeResponse.data;
      } else {
        logError('Failed to search anime: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      logError('Error searching anime: $e');
      return null;
    }
  }

  /// 按类型筛选动漫
  Future<List<Anime>?> getAnimesByGenre(int genreId, int page) async {
    try {
      final response = await animeAPIService.getAnimeByGenre(genreId, page: page);
      if (response.statusCode == 200) {
        final animeResponse = AnimeResponse.fromJson(response.data);
        return animeResponse.data;
      } else {
        logError('Failed to load anime by genre: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      logError('Error loading anime by genre: $e');
      return null;
    }
  }
}
