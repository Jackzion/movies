import 'package:movies/data/models/anime.dart';
import 'package:movies/data/models/favorite.dart';
import 'package:movies/network/anime_api_service.dart';

/// 动漫视图模型
/// 负责管理动漫数据的加载和分类
/// 包含正在流行、评分最高、最受欢迎、正在上映的动漫列表
class AnimeViewModel {
  /// 动漫 API 服务
  final AnimeAPIService animeAPIService;

  /// 动漫类型列表
  late List<String> animeGenres;
  /// 正在流行的动漫列表
  List<Anime> trendingAnimes = [];
  /// 评分最高的动漫列表
  List<Anime> topRatedAnimes = [];
  /// 最受欢迎的动漫列表
  List<Anime> popularAnimes = [];
  /// 正在上映的动漫列表
  List<Anime> nowPlayingAnimes = [];
  /// 所有动漫列表
  List<Anime> allAnimes = [];
  /// 收藏动漫流
  Stream<List<Favorite>>? favoriteStream = null;
  /// 收藏动漫列表
  List<Favorite>? favoriteList = null;

  /// 构造函数
  AnimeViewModel({required this.animeAPIService});

  /// 初始化视图模型
  /// 使用 Future.wait 等待所有异步操作完成
  Future<void> setup() async {
    await Future.wait([
      setupConfiguration(),
      setupGenres(),
      loadAnimes(),
    ]);
  }

  /// 加载配置信息
  Future<void> setupConfiguration() async {
    // TODO: 添加配置加载逻辑
  }

  /// 加载动漫类型列表
  Future<void> setupGenres() async {
    animeGenres = [
      'Action',
      'Adventure',
      'Crime',
      'Mystery',
      'War',
      'Comedy',
      'Romance',
      'History',
      'Music',
      'Drama',
      'Thriller',
      'Family',
      'Horror',
      'Western',
      'Science Fiction',
      'Animation',
      'Documentation',
      'TV Movie',
      'Fantasy',
    ];
  }

  /// 加载所有动漫数据
  Future<void> loadAnimes() async {
    allAnimes = [
      Anime.fromJson({
        'mal_id': 1,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 2,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/gKkl37BQuKTanygYQG1pyYgLVgf.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/gKkl37BQuKTanygYQG1pyYgLVgf.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 3,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 4,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/uuA01PTtPombRPvL9dvsBqOBJWm.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/uuA01PTtPombRPvL9dvsBqOBJWm.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 5,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/H6vke7zGiuLsz4v4RPeReb9rsv.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/H6vke7zGiuLsz4v4RPeReb9rsv.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 6,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 7,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 8,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/pKaA8VvfkNfEMUPMiiuL5qSPQYy.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/pKaA8VvfkNfEMUPMiiuL5qSPQYy.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 9,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/zK2sFxZcelHJRPVr242rxy5VK4T.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/zK2sFxZcelHJRPVr242rxy5VK4T.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 10,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/7qxG0zyt29BI0IzFDfsps62kbQi.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/7qxG0zyt29BI0IzFDfsps62kbQi.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 11,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 12,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/zDi2U7WYkdIoGYHcYbM9X5yReVD.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/zDi2U7WYkdIoGYHcYbM9X5yReVD.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 13,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/cxevDYdeFkiixRShbObdwAHBZry.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/cxevDYdeFkiixRShbObdwAHBZry.jpg'}},
      }),
      Anime.fromJson({
        'mal_id': 14,
        'title': 'Title',
        'synopsis': 'Overview',
        'images': {'jpg': {'image_url': 'http://image.tmdb.org/t/p/w780/uXUs1fwSuE06LgYETw2mi4JxQvc.jpg', 'large_image_url': 'http://image.tmdb.org/t/p/w780/uXUs1fwSuE06LgYETw2mi4JxQvc.jpg'}},
      }),
    ];
  }

  /// 根据动漫 ID 查找动漫
  Anime findAnimeById(int animeId) {
    return allAnimes.firstWhere(
      (anime) => anime.animeId == animeId,
      orElse: () => allAnimes.first,
    );
  }

  /// 获取正在流行的动漫列表
  Future<List<Anime>> getTrendingAnimes(int page) async {
    if (trendingAnimes.isEmpty) {
      trendingAnimes = [
        allAnimes[0],
        allAnimes[2],
        allAnimes[4],
        allAnimes[6],
        allAnimes[8],
        allAnimes[10],
        allAnimes[12],
      ];
    }
    return trendingAnimes;
  }

  /// 获取最受欢迎的动漫列表
  Future<List<Anime>> getPopular(int page) async {
    if (popularAnimes.isEmpty) {
      popularAnimes = [
        allAnimes[1],
        allAnimes[3],
        allAnimes[5],
        allAnimes[7],
        allAnimes[9],
        allAnimes[11],
        allAnimes[13],
      ];
    }
    return popularAnimes;
  }

  /// 获取评分最高的动漫列表
  Future<List<Anime>> getTopRated(int page) async {
    if (topRatedAnimes.isEmpty) {
      topRatedAnimes = [
        allAnimes[0],
        allAnimes[4],
        allAnimes[8],
        allAnimes[12],
      ];
    }
    return topRatedAnimes;
  }

  /// 获取正在上映的动漫列表
  Future<List<Anime>> getNowPlaying(int page) async {
    if (nowPlayingAnimes.isEmpty) {
      nowPlayingAnimes = [
        allAnimes[8],
        allAnimes[10],
        allAnimes[12],
        allAnimes[0],
        allAnimes[2],
        allAnimes[4],
        allAnimes[6],
      ];
    }
    return nowPlayingAnimes;
  }

  /// 创建收藏动漫流
  /// 首次调用时初始化收藏列表，后续直接返回流
  Stream<List<Favorite>> streamFavorites() {
    if (favoriteList == null) {
      favoriteList = [
        Favorite(
          animeId: 1,
          image: 'http://image.tmdb.org/t/p/w780/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg',
          favorite: false,
          title: 'Title',
          overview: 'Overview',
          popularity: 1.0,
          releaseDate: DateTime.now(),
        ),
        Favorite(
          animeId: 2,
          image: 'http://image.tmdb.org/t/p/w780/gKkl37BQuKTanygYQG1pyYgLVgf.jpg',
          favorite: false,
          title: 'Title',
          overview: 'Overview',
          popularity: 1.0,
          releaseDate: DateTime.now(),
        ),
        Favorite(
          animeId: 3,
          image: 'http://image.tmdb.org/t/p/w780/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg',
          favorite: false,
          title: 'Title',
          overview: 'Overview',
          popularity: 1.0,
          releaseDate: DateTime.now(),
        ),
        Favorite(
          animeId: 4,
          image: 'http://image.tmdb.org/t/p/w780/uuA01PTtPombRPvL9dvsBqOBJWm.jpg',
          favorite: false,
          title: 'Title',
          overview: 'Overview',
          popularity: 1.0,
          releaseDate: DateTime.now(),
        ),
        Favorite(
          animeId: 5,
          image: 'http://image.tmdb.org/t/p/w780/H6vke7zGiuLsz4v4RPeReb9rsv.jpg',
          favorite: false,
          title: 'Title',
          overview: 'Overview',
          popularity: 1.0,
          releaseDate: DateTime.now(),
        ),
      ];
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
}
