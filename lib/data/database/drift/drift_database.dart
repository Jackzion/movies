import 'package:drift/drift.dart';
import 'package:movies/data/database/drift/anime_database.dart';
import 'package:movies/data/database/models/database_interface.dart';
import 'package:movies/data/database/models/database_models.dart';

/// Drift 数据库实现
class DriftDatabase implements IDatabase {
  final AnimeDatabase animeDatabase;

  DriftDatabase() : animeDatabase = AnimeDatabase();

  DriftDatabase.test(this.animeDatabase);

  @override
  Future deleteDatabase() async {
    await animeDatabase.close();
  }

  @override
  Future<List<DBFavorite>> getFavorites() async {
    final favorites = await animeDatabase.managers.driftFavorite.get();
    return favorites
        .map(
          (favorite) => DBFavorite(
            id: favorite.id,
            animeId: favorite.animeId,
            posterPath: favorite.posterPath,
            bannerPath: favorite.bannerPath,
            favorite: favorite.favorite,
            popularity: favorite.popularity,
            releaseDate: favorite.releaseDate,
            title: favorite.title,
            overview: favorite.overview,
          ),
        )
        .toList();
  }

  @override
  Future<List<DBAnimeGenre>> getGenres() async {
    final genres = await animeDatabase.managers.driftGenre.get();
    return genres
        .map(
          (genre) => DBAnimeGenre(
            id: genre.id,
            remoteId: genre.remoteId,
            name: genre.name,
          ),
        )
        .toList();
  }

  @override
  Future<bool> removeFavorite(int id) async {
    final count = await animeDatabase.driftFavorite
        .deleteWhere((table) => table.id.equals(id));
    return count > 0;
  }

  @override
  Future saveFavorite(DBFavorite favorite) async {
    await animeDatabase.managers.driftFavorite.create(
      (_) => DriftFavoriteCompanion.insert(
        animeId: favorite.animeId,
        posterPath: favorite.posterPath,
        bannerPath: Value(favorite.bannerPath),
        favorite: favorite.favorite,
        popularity: favorite.popularity,
        releaseDate: favorite.releaseDate,
        title: favorite.title,
        overview: favorite.overview,
      ),
    );
  }

  @override
  Future saveGenres(List<DBAnimeGenre> genres) async {
    await animeDatabase.batch((batch) {
      batch.insertAllOnConflictUpdate(
        animeDatabase.driftGenre,
        [
          for (final genre in genres)
            DriftGenreCompanion.insert(
              remoteId: genre.remoteId,
              name: genre.name,
            ),
        ],
      );
    });
  }

  @override
  Stream<List<DBFavorite>> streamFavorites() {
    return animeDatabase.managers.driftFavorite.watch().map(
          (rows) => rows
              .map(
                (favorite) => DBFavorite(
                  id: favorite.id,
                  animeId: favorite.animeId,
                  posterPath: favorite.posterPath,
                  bannerPath: favorite.bannerPath,
                  favorite: favorite.favorite,
                  popularity: favorite.popularity,
                  releaseDate: favorite.releaseDate,
                  title: favorite.title,
                  overview: favorite.overview,
                ),
              )
              .toList(),
        );
  }
}
