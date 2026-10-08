import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'anime_database.g.dart';

/// 收藏表（存全量字段，重启无需再请求）
class DriftFavorite extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get animeId => integer()();

  TextColumn get posterPath => text()();

  TextColumn get bannerPath => text().nullable()();

  BoolColumn get favorite => boolean()();

  RealColumn get popularity => real()();

  DateTimeColumn get releaseDate => dateTime()();

  TextColumn get title => text()();

  TextColumn get overview => text()();
}

/// 类型/标签表
class DriftGenre extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  TextColumn get name => text()();
}

@DriftDatabase(
  tables: [DriftFavorite, DriftGenre],
)
class AnimeDatabase extends _$AnimeDatabase {
  AnimeDatabase() : super(driftDatabase(name: 'Animes'));

  AnimeDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
