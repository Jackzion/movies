// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_database.dart';

// ignore_for_file: type=lint
class $DriftFavoriteTable extends DriftFavorite
    with TableInfo<$DriftFavoriteTable, DriftFavoriteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftFavoriteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _animeIdMeta = const VerificationMeta(
    'animeId',
  );
  @override
  late final GeneratedColumn<int> animeId = GeneratedColumn<int>(
    'anime_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posterPathMeta = const VerificationMeta(
    'posterPath',
  );
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
    'poster_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bannerPathMeta = const VerificationMeta(
    'bannerPath',
  );
  @override
  late final GeneratedColumn<String> bannerPath = GeneratedColumn<String>(
    'banner_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _favoriteMeta = const VerificationMeta(
    'favorite',
  );
  @override
  late final GeneratedColumn<bool> favorite = GeneratedColumn<bool>(
    'favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("favorite" IN (0, 1))',
    ),
  );
  static const VerificationMeta _popularityMeta = const VerificationMeta(
    'popularity',
  );
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
    'popularity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> releaseDate = GeneratedColumn<DateTime>(
    'release_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animeId,
    posterPath,
    bannerPath,
    favorite,
    popularity,
    releaseDate,
    title,
    overview,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_favorite';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftFavoriteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('anime_id')) {
      context.handle(
        _animeIdMeta,
        animeId.isAcceptableOrUnknown(data['anime_id']!, _animeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animeIdMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
        _posterPathMeta,
        posterPath.isAcceptableOrUnknown(data['poster_path']!, _posterPathMeta),
      );
    } else if (isInserting) {
      context.missing(_posterPathMeta);
    }
    if (data.containsKey('banner_path')) {
      context.handle(
        _bannerPathMeta,
        bannerPath.isAcceptableOrUnknown(data['banner_path']!, _bannerPathMeta),
      );
    }
    if (data.containsKey('favorite')) {
      context.handle(
        _favoriteMeta,
        favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta),
      );
    } else if (isInserting) {
      context.missing(_favoriteMeta);
    }
    if (data.containsKey('popularity')) {
      context.handle(
        _popularityMeta,
        popularity.isAcceptableOrUnknown(data['popularity']!, _popularityMeta),
      );
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftFavoriteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftFavoriteData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      animeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anime_id'],
      )!,
      posterPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_path'],
      )!,
      bannerPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banner_path'],
      ),
      favorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}favorite'],
      )!,
      popularity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}popularity'],
      )!,
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}release_date'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      )!,
    );
  }

  @override
  $DriftFavoriteTable createAlias(String alias) {
    return $DriftFavoriteTable(attachedDatabase, alias);
  }
}

class DriftFavoriteData extends DataClass
    implements Insertable<DriftFavoriteData> {
  final int id;
  final int animeId;
  final String posterPath;
  final String? bannerPath;
  final bool favorite;
  final double popularity;
  final DateTime releaseDate;
  final String title;
  final String overview;
  const DriftFavoriteData({
    required this.id,
    required this.animeId,
    required this.posterPath,
    this.bannerPath,
    required this.favorite,
    required this.popularity,
    required this.releaseDate,
    required this.title,
    required this.overview,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['anime_id'] = Variable<int>(animeId);
    map['poster_path'] = Variable<String>(posterPath);
    if (!nullToAbsent || bannerPath != null) {
      map['banner_path'] = Variable<String>(bannerPath);
    }
    map['favorite'] = Variable<bool>(favorite);
    map['popularity'] = Variable<double>(popularity);
    map['release_date'] = Variable<DateTime>(releaseDate);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    return map;
  }

  DriftFavoriteCompanion toCompanion(bool nullToAbsent) {
    return DriftFavoriteCompanion(
      id: Value(id),
      animeId: Value(animeId),
      posterPath: Value(posterPath),
      bannerPath: bannerPath == null && nullToAbsent
          ? const Value.absent()
          : Value(bannerPath),
      favorite: Value(favorite),
      popularity: Value(popularity),
      releaseDate: Value(releaseDate),
      title: Value(title),
      overview: Value(overview),
    );
  }

  factory DriftFavoriteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftFavoriteData(
      id: serializer.fromJson<int>(json['id']),
      animeId: serializer.fromJson<int>(json['animeId']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      bannerPath: serializer.fromJson<String?>(json['bannerPath']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      popularity: serializer.fromJson<double>(json['popularity']),
      releaseDate: serializer.fromJson<DateTime>(json['releaseDate']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'animeId': serializer.toJson<int>(animeId),
      'posterPath': serializer.toJson<String>(posterPath),
      'bannerPath': serializer.toJson<String?>(bannerPath),
      'favorite': serializer.toJson<bool>(favorite),
      'popularity': serializer.toJson<double>(popularity),
      'releaseDate': serializer.toJson<DateTime>(releaseDate),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
    };
  }

  DriftFavoriteData copyWith({
    int? id,
    int? animeId,
    String? posterPath,
    Value<String?> bannerPath = const Value.absent(),
    bool? favorite,
    double? popularity,
    DateTime? releaseDate,
    String? title,
    String? overview,
  }) => DriftFavoriteData(
    id: id ?? this.id,
    animeId: animeId ?? this.animeId,
    posterPath: posterPath ?? this.posterPath,
    bannerPath: bannerPath.present ? bannerPath.value : this.bannerPath,
    favorite: favorite ?? this.favorite,
    popularity: popularity ?? this.popularity,
    releaseDate: releaseDate ?? this.releaseDate,
    title: title ?? this.title,
    overview: overview ?? this.overview,
  );
  DriftFavoriteData copyWithCompanion(DriftFavoriteCompanion data) {
    return DriftFavoriteData(
      id: data.id.present ? data.id.value : this.id,
      animeId: data.animeId.present ? data.animeId.value : this.animeId,
      posterPath: data.posterPath.present
          ? data.posterPath.value
          : this.posterPath,
      bannerPath: data.bannerPath.present
          ? data.bannerPath.value
          : this.bannerPath,
      favorite: data.favorite.present ? data.favorite.value : this.favorite,
      popularity: data.popularity.present
          ? data.popularity.value
          : this.popularity,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      title: data.title.present ? data.title.value : this.title,
      overview: data.overview.present ? data.overview.value : this.overview,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftFavoriteData(')
          ..write('id: $id, ')
          ..write('animeId: $animeId, ')
          ..write('posterPath: $posterPath, ')
          ..write('bannerPath: $bannerPath, ')
          ..write('favorite: $favorite, ')
          ..write('popularity: $popularity, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('overview: $overview')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animeId,
    posterPath,
    bannerPath,
    favorite,
    popularity,
    releaseDate,
    title,
    overview,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftFavoriteData &&
          other.id == this.id &&
          other.animeId == this.animeId &&
          other.posterPath == this.posterPath &&
          other.bannerPath == this.bannerPath &&
          other.favorite == this.favorite &&
          other.popularity == this.popularity &&
          other.releaseDate == this.releaseDate &&
          other.title == this.title &&
          other.overview == this.overview);
}

class DriftFavoriteCompanion extends UpdateCompanion<DriftFavoriteData> {
  final Value<int> id;
  final Value<int> animeId;
  final Value<String> posterPath;
  final Value<String?> bannerPath;
  final Value<bool> favorite;
  final Value<double> popularity;
  final Value<DateTime> releaseDate;
  final Value<String> title;
  final Value<String> overview;
  const DriftFavoriteCompanion({
    this.id = const Value.absent(),
    this.animeId = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.bannerPath = const Value.absent(),
    this.favorite = const Value.absent(),
    this.popularity = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
  });
  DriftFavoriteCompanion.insert({
    this.id = const Value.absent(),
    required int animeId,
    required String posterPath,
    this.bannerPath = const Value.absent(),
    required bool favorite,
    required double popularity,
    required DateTime releaseDate,
    required String title,
    required String overview,
  }) : animeId = Value(animeId),
       posterPath = Value(posterPath),
       favorite = Value(favorite),
       popularity = Value(popularity),
       releaseDate = Value(releaseDate),
       title = Value(title),
       overview = Value(overview);
  static Insertable<DriftFavoriteData> custom({
    Expression<int>? id,
    Expression<int>? animeId,
    Expression<String>? posterPath,
    Expression<String>? bannerPath,
    Expression<bool>? favorite,
    Expression<double>? popularity,
    Expression<DateTime>? releaseDate,
    Expression<String>? title,
    Expression<String>? overview,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animeId != null) 'anime_id': animeId,
      if (posterPath != null) 'poster_path': posterPath,
      if (bannerPath != null) 'banner_path': bannerPath,
      if (favorite != null) 'favorite': favorite,
      if (popularity != null) 'popularity': popularity,
      if (releaseDate != null) 'release_date': releaseDate,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
    });
  }

  DriftFavoriteCompanion copyWith({
    Value<int>? id,
    Value<int>? animeId,
    Value<String>? posterPath,
    Value<String?>? bannerPath,
    Value<bool>? favorite,
    Value<double>? popularity,
    Value<DateTime>? releaseDate,
    Value<String>? title,
    Value<String>? overview,
  }) {
    return DriftFavoriteCompanion(
      id: id ?? this.id,
      animeId: animeId ?? this.animeId,
      posterPath: posterPath ?? this.posterPath,
      bannerPath: bannerPath ?? this.bannerPath,
      favorite: favorite ?? this.favorite,
      popularity: popularity ?? this.popularity,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      overview: overview ?? this.overview,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (animeId.present) {
      map['anime_id'] = Variable<int>(animeId.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (bannerPath.present) {
      map['banner_path'] = Variable<String>(bannerPath.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftFavoriteCompanion(')
          ..write('id: $id, ')
          ..write('animeId: $animeId, ')
          ..write('posterPath: $posterPath, ')
          ..write('bannerPath: $bannerPath, ')
          ..write('favorite: $favorite, ')
          ..write('popularity: $popularity, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('title: $title, ')
          ..write('overview: $overview')
          ..write(')'))
        .toString();
  }
}

class $DriftGenreTable extends DriftGenre
    with TableInfo<$DriftGenreTable, DriftGenreData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftGenreTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, remoteId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_genre';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftGenreData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_remoteIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftGenreData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftGenreData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $DriftGenreTable createAlias(String alias) {
    return $DriftGenreTable(attachedDatabase, alias);
  }
}

class DriftGenreData extends DataClass implements Insertable<DriftGenreData> {
  final int id;
  final int remoteId;
  final String name;
  const DriftGenreData({
    required this.id,
    required this.remoteId,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['remote_id'] = Variable<int>(remoteId);
    map['name'] = Variable<String>(name);
    return map;
  }

  DriftGenreCompanion toCompanion(bool nullToAbsent) {
    return DriftGenreCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      name: Value(name),
    );
  }

  factory DriftGenreData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftGenreData(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int>(json['remoteId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int>(remoteId),
      'name': serializer.toJson<String>(name),
    };
  }

  DriftGenreData copyWith({int? id, int? remoteId, String? name}) =>
      DriftGenreData(
        id: id ?? this.id,
        remoteId: remoteId ?? this.remoteId,
        name: name ?? this.name,
      );
  DriftGenreData copyWithCompanion(DriftGenreCompanion data) {
    return DriftGenreData(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftGenreData(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, remoteId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftGenreData &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.name == this.name);
}

class DriftGenreCompanion extends UpdateCompanion<DriftGenreData> {
  final Value<int> id;
  final Value<int> remoteId;
  final Value<String> name;
  const DriftGenreCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.name = const Value.absent(),
  });
  DriftGenreCompanion.insert({
    this.id = const Value.absent(),
    required int remoteId,
    required String name,
  }) : remoteId = Value(remoteId),
       name = Value(name);
  static Insertable<DriftGenreData> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (name != null) 'name': name,
    });
  }

  DriftGenreCompanion copyWith({
    Value<int>? id,
    Value<int>? remoteId,
    Value<String>? name,
  }) {
    return DriftGenreCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftGenreCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract class _$AnimeDatabase extends GeneratedDatabase {
  _$AnimeDatabase(QueryExecutor e) : super(e);
  $AnimeDatabaseManager get managers => $AnimeDatabaseManager(this);
  late final $DriftFavoriteTable driftFavorite = $DriftFavoriteTable(this);
  late final $DriftGenreTable driftGenre = $DriftGenreTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    driftFavorite,
    driftGenre,
  ];
}

typedef $$DriftFavoriteTableCreateCompanionBuilder =
    DriftFavoriteCompanion Function({
      Value<int> id,
      required int animeId,
      required String posterPath,
      Value<String?> bannerPath,
      required bool favorite,
      required double popularity,
      required DateTime releaseDate,
      required String title,
      required String overview,
    });
typedef $$DriftFavoriteTableUpdateCompanionBuilder =
    DriftFavoriteCompanion Function({
      Value<int> id,
      Value<int> animeId,
      Value<String> posterPath,
      Value<String?> bannerPath,
      Value<bool> favorite,
      Value<double> popularity,
      Value<DateTime> releaseDate,
      Value<String> title,
      Value<String> overview,
    });

class $$DriftFavoriteTableFilterComposer
    extends Composer<_$AnimeDatabase, $DriftFavoriteTable> {
  $$DriftFavoriteTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bannerPath => $composableBuilder(
    column: $table.bannerPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftFavoriteTableOrderingComposer
    extends Composer<_$AnimeDatabase, $DriftFavoriteTable> {
  $$DriftFavoriteTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bannerPath => $composableBuilder(
    column: $table.bannerPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftFavoriteTableAnnotationComposer
    extends Composer<_$AnimeDatabase, $DriftFavoriteTable> {
  $$DriftFavoriteTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get animeId =>
      $composableBuilder(column: $table.animeId, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
    column: $table.posterPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bannerPath => $composableBuilder(
    column: $table.bannerPath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get favorite =>
      $composableBuilder(column: $table.favorite, builder: (column) => column);

  GeneratedColumn<double> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);
}

class $$DriftFavoriteTableTableManager
    extends
        RootTableManager<
          _$AnimeDatabase,
          $DriftFavoriteTable,
          DriftFavoriteData,
          $$DriftFavoriteTableFilterComposer,
          $$DriftFavoriteTableOrderingComposer,
          $$DriftFavoriteTableAnnotationComposer,
          $$DriftFavoriteTableCreateCompanionBuilder,
          $$DriftFavoriteTableUpdateCompanionBuilder,
          (
            DriftFavoriteData,
            BaseReferences<
              _$AnimeDatabase,
              $DriftFavoriteTable,
              DriftFavoriteData
            >,
          ),
          DriftFavoriteData,
          PrefetchHooks Function()
        > {
  $$DriftFavoriteTableTableManager(
    _$AnimeDatabase db,
    $DriftFavoriteTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DriftFavoriteTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DriftFavoriteTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DriftFavoriteTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> animeId = const Value.absent(),
                Value<String> posterPath = const Value.absent(),
                Value<String?> bannerPath = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<double> popularity = const Value.absent(),
                Value<DateTime> releaseDate = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> overview = const Value.absent(),
              }) => DriftFavoriteCompanion(
                id: id,
                animeId: animeId,
                posterPath: posterPath,
                bannerPath: bannerPath,
                favorite: favorite,
                popularity: popularity,
                releaseDate: releaseDate,
                title: title,
                overview: overview,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int animeId,
                required String posterPath,
                Value<String?> bannerPath = const Value.absent(),
                required bool favorite,
                required double popularity,
                required DateTime releaseDate,
                required String title,
                required String overview,
              }) => DriftFavoriteCompanion.insert(
                id: id,
                animeId: animeId,
                posterPath: posterPath,
                bannerPath: bannerPath,
                favorite: favorite,
                popularity: popularity,
                releaseDate: releaseDate,
                title: title,
                overview: overview,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DriftFavoriteTable, DriftFavoriteData>(table),
                  BaseReferences<
                    _$AnimeDatabase,
                    $DriftFavoriteTable,
                    DriftFavoriteData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftFavoriteTableProcessedTableManager =
    ProcessedTableManager<
      _$AnimeDatabase,
      $DriftFavoriteTable,
      DriftFavoriteData,
      $$DriftFavoriteTableFilterComposer,
      $$DriftFavoriteTableOrderingComposer,
      $$DriftFavoriteTableAnnotationComposer,
      $$DriftFavoriteTableCreateCompanionBuilder,
      $$DriftFavoriteTableUpdateCompanionBuilder,
      (
        DriftFavoriteData,
        BaseReferences<_$AnimeDatabase, $DriftFavoriteTable, DriftFavoriteData>,
      ),
      DriftFavoriteData,
      PrefetchHooks Function()
    >;
typedef $$DriftGenreTableCreateCompanionBuilder = DriftGenreCompanion Function({
  Value<int> id,
  required int remoteId,
  required String name,
});
typedef $$DriftGenreTableUpdateCompanionBuilder = DriftGenreCompanion Function({
  Value<int> id,
  Value<int> remoteId,
  Value<String> name,
});

class $$DriftGenreTableFilterComposer
    extends Composer<_$AnimeDatabase, $DriftGenreTable> {
  $$DriftGenreTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftGenreTableOrderingComposer
    extends Composer<_$AnimeDatabase, $DriftGenreTable> {
  $$DriftGenreTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftGenreTableAnnotationComposer
    extends Composer<_$AnimeDatabase, $DriftGenreTable> {
  $$DriftGenreTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$DriftGenreTableTableManager
    extends
        RootTableManager<
          _$AnimeDatabase,
          $DriftGenreTable,
          DriftGenreData,
          $$DriftGenreTableFilterComposer,
          $$DriftGenreTableOrderingComposer,
          $$DriftGenreTableAnnotationComposer,
          $$DriftGenreTableCreateCompanionBuilder,
          $$DriftGenreTableUpdateCompanionBuilder,
          (
            DriftGenreData,
            BaseReferences<_$AnimeDatabase, $DriftGenreTable, DriftGenreData>,
          ),
          DriftGenreData,
          PrefetchHooks Function()
        > {
  $$DriftGenreTableTableManager(_$AnimeDatabase db, $DriftGenreTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DriftGenreTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DriftGenreTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DriftGenreTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> remoteId = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => DriftGenreCompanion(id: id, remoteId: remoteId, name: name),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int remoteId,
                required String name,
              }) => DriftGenreCompanion.insert(
                id: id,
                remoteId: remoteId,
                name: name,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DriftGenreTable, DriftGenreData>(table),
                  BaseReferences<
                    _$AnimeDatabase,
                    $DriftGenreTable,
                    DriftGenreData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftGenreTableProcessedTableManager =
    ProcessedTableManager<
      _$AnimeDatabase,
      $DriftGenreTable,
      DriftGenreData,
      $$DriftGenreTableFilterComposer,
      $$DriftGenreTableOrderingComposer,
      $$DriftGenreTableAnnotationComposer,
      $$DriftGenreTableCreateCompanionBuilder,
      $$DriftGenreTableUpdateCompanionBuilder,
      (
        DriftGenreData,
        BaseReferences<_$AnimeDatabase, $DriftGenreTable, DriftGenreData>,
      ),
      DriftGenreData,
      PrefetchHooks Function()
    >;

class $AnimeDatabaseManager {
  final _$AnimeDatabase _db;
  $AnimeDatabaseManager(this._db);
  $$DriftFavoriteTableTableManager get driftFavorite =>
      $$DriftFavoriteTableTableManager(_db, _db.driftFavorite);
  $$DriftGenreTableTableManager get driftGenre =>
      $$DriftGenreTableTableManager(_db, _db.driftGenre);
}
