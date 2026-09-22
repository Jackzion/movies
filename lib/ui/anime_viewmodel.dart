import 'package:lumberdash/lumberdash.dart';
import 'package:movies/data/models/anime.dart';
import 'package:movies/data/models/anime_details.dart';
import 'package:movies/data/models/anime_response.dart';
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
          // 打印响应数据结构，用于调试
          final data = response.data;
          print('API Response type: ${data.runtimeType}');
          print('API Response keys: ${data is Map ? data.keys.toList() : "not a map"}');

          // Jikan API v4 响应格式: { "data": { ... } }
          final animeData = data is Map<String, dynamic> ? data['data'] : data;
          print('AnimeData type: ${animeData.runtimeType}');

          return AnimeDetails.fromJson(animeData as Map<String, dynamic>);
        } catch (e) {
          logError('Failed to parse anime details: $e');
          print('Parse error details: $e');
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
}
