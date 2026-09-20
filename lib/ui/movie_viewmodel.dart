import 'package:movies/data/models/movie.dart';

/// 电影视图模型
/// 负责管理电影数据的加载和分类
/// 包含正在流行、评分最高、最受欢迎、正在上映的电影列表
class MovieViewModel {
  /// 电影类型列表
  late List<String> movieGenres;
  /// 正在流行的电影列表
  List<Movie> trendingMovies = [];
  /// 评分最高的电影列表
  List<Movie> topRatedMovies = [];
  /// 最受欢迎的电影列表
  List<Movie> popularMovies = [];
  /// 正在上映的电影列表
  List<Movie> nowPlayingMovies = [];
  /// 所有电影列表
  List<Movie> allMovies = [];

  /// 初始化视图模型
  /// 使用 Future.wait 等待所有异步操作完成
  Future<void> setup() async {
    await Future.wait([
      setupConfiguration(),
      setupGenres(),
      loadMovies(),
    ]);
  }

  /// 加载配置信息
  Future<void> setupConfiguration() async {
    // TODO: 添加配置加载逻辑
  }

  /// 加载电影类型列表
  Future<void> setupGenres() async {
    movieGenres = [
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

  /// 加载所有电影数据
  Future<void> loadMovies() async {
    allMovies = [
      Movie(
        movieId: 1,
        image: 'http://image.tmdb.org/t/p/w780/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 2,
        image: 'http://image.tmdb.org/t/p/w780/gKkl37BQuKTanygYQG1pyYgLVgf.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 3,
        image: 'http://image.tmdb.org/t/p/w780/4xJd3uwtL1vCuZgEfEc8JXI9Uyx.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 4,
        image: 'http://image.tmdb.org/t/p/w780/uuA01PTtPombRPvL9dvsBqOBJWm.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 5,
        image: 'http://image.tmdb.org/t/p/w780/H6vke7zGiuLsz4v4RPeReb9rsv.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 6,
        image: 'http://image.tmdb.org/t/p/w780/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 7,
        image: 'http://image.tmdb.org/t/p/w780/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 8,
        image: 'http://image.tmdb.org/t/p/w780/pKaA8VvfkNfEMUPMiiuL5qSPQYy.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 9,
        image: 'http://image.tmdb.org/t/p/w780/zK2sFxZcelHJRPVr242rxy5VK4T.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 10,
        image: 'http://image.tmdb.org/t/p/w780/7qxG0zyt29BI0IzFDfsps62kbQi.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 11,
        image: 'http://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 12,
        image: 'http://image.tmdb.org/t/p/w780/zDi2U7WYkdIoGYHcYbM9X5yReVD.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 13,
        image: 'http://image.tmdb.org/t/p/w780/cxevDYdeFkiixRShbObdwAHBZry.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
      Movie(
        movieId: 14,
        image: 'http://image.tmdb.org/t/p/w780/uXUs1fwSuE06LgYETw2mi4JxQvc.jpg',
        title: 'Title',
        overview: 'Overview',
        popularity: 1.0,
        releaseDate: DateTime.now(),
      ),
    ];
  }

  /// 根据电影 ID 查找电影
  Movie findMovieById(int movieId) {
    return allMovies.firstWhere(
      (movie) => movie.movieId == movieId,
      orElse: () => allMovies.first,
    );
  }

  /// 获取正在流行的电影列表
  Future<List<Movie>> getTrendingMovies(int page) async {
    if (trendingMovies.isEmpty) {
      trendingMovies = [
        allMovies[0],
        allMovies[2],
        allMovies[4],
        allMovies[6],
        allMovies[8],
        allMovies[10],
        allMovies[12],
      ];
    }
    return trendingMovies;
  }

  /// 获取最受欢迎的电影列表
  Future<List<Movie>> getPopular(int page) async {
    if (popularMovies.isEmpty) {
      popularMovies = [
        allMovies[1],
        allMovies[3],
        allMovies[5],
        allMovies[7],
        allMovies[9],
        allMovies[11],
        allMovies[13],
      ];
    }
    return popularMovies;
  }

  /// 获取评分最高的电影列表
  Future<List<Movie>> getTopRated(int page) async {
    if (topRatedMovies.isEmpty) {
      topRatedMovies = [
        allMovies[0],
        allMovies[4],
        allMovies[8],
        allMovies[12],
      ];
    }
    return topRatedMovies;
  }

  /// 获取正在上映的电影列表
  Future<List<Movie>> getNowPlaying(int page) async {
    if (nowPlayingMovies.isEmpty) {
      nowPlayingMovies = [
        allMovies[8],
        allMovies[10],
        allMovies[12],
        allMovies[0],
        allMovies[2],
        allMovies[4],
        allMovies[6],
      ];
    }
    return nowPlayingMovies;
  }
}
