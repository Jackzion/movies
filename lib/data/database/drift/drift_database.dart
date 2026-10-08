import 'package:drift/drift.dart';
import 'package:movies/data/database/drift/anime_database.dart';
import 'package:movies/data/database/models/database_interface.dart';
import 'package:movies/data/database/models/database_models.dart';
import 'package:movies/data/models/anime_image_configuration.dart';

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
  Future<DBAnimeImageConfiguration?> getAnimeImageConfiguration() async {
    final rows =
        await animeDatabase.managers.driftConfigurationImages.get();
    if (rows.isEmpty) {
      return null;
    }
    final row = rows.first;
    return DBAnimeImageConfiguration(
      id: row.id,
      configuration: AnimeImageConfiguration(
        bangumiHost: row.bangumiHost,
        anilistHost: row.anilistHost,
        bangumiSizes: row.bangumiSizes.split(','),
        bangumiPathSizes: row.bangumiPathSizes.split(','),
        bangumiResizeWidths: row.bangumiResizeWidths
            .split(',')
            .map((e) => int.tryParse(e) ?? 0)
            .where((e) => e > 0)
            .toList(),
        anilistCoverSizes: row.anilistCoverSizes.split(','),
        anilistCharacterSizes: row.anilistCharacterSizes.split(','),
      ),
    );
  }

  @override
  Future<DBAnimeImageConfiguration?> getAnimeImageConfigurationById(
    int id,
  ) async {
    return getAnimeImageConfiguration();
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
  Future saveAnimeImageConfiguration(
    DBAnimeImageConfiguration configuration,
  ) async {
    final config = configuration.configuration;
    await animeDatabase.driftConfigurationImages.deleteAll();
    await animeDatabase.managers.driftConfigurationImages.create(
      (_) => DriftConfigurationImagesCompanion.insert(
        bangumiHost: config.bangumiHost,
        anilistHost: config.anilistHost,
        bangumiSizes: config.bangumiSizes.join(','),
        bangumiPathSizes: config.bangumiPathSizes.join(','),
        bangumiResizeWidths: config.bangumiResizeWidths.join(','),
        anilistCoverSizes: config.anilistCoverSizes.join(','),
        anilistCharacterSizes: config.anilistCharacterSizes.join(','),
      ),
    );
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
