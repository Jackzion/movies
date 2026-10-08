import 'package:movies/data/database/models/database_models.dart';

/// 数据库抽象接口
/// UI/ViewModel 只依赖本接口，便于替换 Drift 或其他实现
abstract class IDatabase {
  Future deleteDatabase();

  Future<List<DBAnimeGenre>> getGenres();

  Future saveGenres(List<DBAnimeGenre> genres);

  Future<DBAnimeImageConfiguration?> getAnimeImageConfiguration();

  Future<DBAnimeImageConfiguration?> getAnimeImageConfigurationById(int id);

  Future saveAnimeImageConfiguration(DBAnimeImageConfiguration configuration);

  Future saveFavorite(DBFavorite favorite);

  Future<bool> removeFavorite(int id);

  Future<List<DBFavorite>> getFavorites();

  Stream<List<DBFavorite>> streamFavorites();
}
