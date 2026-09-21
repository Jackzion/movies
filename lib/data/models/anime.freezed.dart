// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anime.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Anime _$AnimeFromJson(Map<String, dynamic> json) {
  return _Anime.fromJson(json);
}

/// @nodoc
mixin _$Anime {
  /// 动漫 ID
  int get malId => throw _privateConstructorUsedError;

  /// 动漫标题
  String? get title => throw _privateConstructorUsedError;

  /// 英文标题
  @JsonKey(name: 'title_english')
  String? get titleEnglish => throw _privateConstructorUsedError;

  /// 图片 URL
  Images? get images => throw _privateConstructorUsedError;

  /// 是否正在播出
  @JsonKey(name: 'airing')
  bool? get airing => throw _privateConstructorUsedError;

  /// 评分
  double? get score => throw _privateConstructorUsedError;

  /// 评分人数
  @JsonKey(name: 'scored_by')
  int? get scoredBy => throw _privateConstructorUsedError;

  /// 排名
  int? get rank => throw _privateConstructorUsedError;

  /// 成员数
  int? get members => throw _privateConstructorUsedError;

  /// 类型 (TV, Movie, OVA, etc.)
  String? get type => throw _privateConstructorUsedError;

  /// 状态 (Finished Airing, Currently Airing, Not yet aired)
  String? get status => throw _privateConstructorUsedError;

  /// 播放集数
  @JsonKey(name: 'episodes')
  int? get episodes => throw _privateConstructorUsedError;

  /// 开始日期
  @JsonKey(name: 'aired', fromJson: _parseDate)
  DateTime? get aired => throw _privateConstructorUsedError;

  /// 简介
  String? get synopsis => throw _privateConstructorUsedError;

  /// 背景
  String? get background => throw _privateConstructorUsedError;

  /// 季节
  String? get season => throw _privateConstructorUsedError;

  /// 年份
  int? get year => throw _privateConstructorUsedError;

  /// 评分等级
  @JsonKey(name: 'rating')
  String? get rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnimeCopyWith<Anime> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimeCopyWith<$Res> {
  factory $AnimeCopyWith(Anime value, $Res Function(Anime) then) =
      _$AnimeCopyWithImpl<$Res, Anime>;
  @useResult
  $Res call(
      {int malId,
      String? title,
      @JsonKey(name: 'title_english') String? titleEnglish,
      Images? images,
      @JsonKey(name: 'airing') bool? airing,
      double? score,
      @JsonKey(name: 'scored_by') int? scoredBy,
      int? rank,
      int? members,
      String? type,
      String? status,
      @JsonKey(name: 'episodes') int? episodes,
      @JsonKey(name: 'aired', fromJson: _parseDate) DateTime? aired,
      String? synopsis,
      String? background,
      String? season,
      int? year,
      @JsonKey(name: 'rating') String? rating});

  $ImagesCopyWith<$Res>? get images;
}

/// @nodoc
class _$AnimeCopyWithImpl<$Res, $Val extends Anime>
    implements $AnimeCopyWith<$Res> {
  _$AnimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? malId = null,
    Object? title = freezed,
    Object? titleEnglish = freezed,
    Object? images = freezed,
    Object? airing = freezed,
    Object? score = freezed,
    Object? scoredBy = freezed,
    Object? rank = freezed,
    Object? members = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? episodes = freezed,
    Object? aired = freezed,
    Object? synopsis = freezed,
    Object? background = freezed,
    Object? season = freezed,
    Object? year = freezed,
    Object? rating = freezed,
  }) {
    return _then(_value.copyWith(
      malId: null == malId
          ? _value.malId
          : malId // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      titleEnglish: freezed == titleEnglish
          ? _value.titleEnglish
          : titleEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Images?,
      airing: freezed == airing
          ? _value.airing
          : airing // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      scoredBy: freezed == scoredBy
          ? _value.scoredBy
          : scoredBy // ignore: cast_nullable_to_non_nullable
              as int?,
      rank: freezed == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as int?,
      aired: freezed == aired
          ? _value.aired
          : aired // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      synopsis: freezed == synopsis
          ? _value.synopsis
          : synopsis // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImagesCopyWith<$Res>? get images {
    if (_value.images == null) {
      return null;
    }

    return $ImagesCopyWith<$Res>(_value.images!, (value) {
      return _then(_value.copyWith(images: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnimeImplCopyWith<$Res> implements $AnimeCopyWith<$Res> {
  factory _$$AnimeImplCopyWith(
          _$AnimeImpl value, $Res Function(_$AnimeImpl) then) =
      __$$AnimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int malId,
      String? title,
      @JsonKey(name: 'title_english') String? titleEnglish,
      Images? images,
      @JsonKey(name: 'airing') bool? airing,
      double? score,
      @JsonKey(name: 'scored_by') int? scoredBy,
      int? rank,
      int? members,
      String? type,
      String? status,
      @JsonKey(name: 'episodes') int? episodes,
      @JsonKey(name: 'aired', fromJson: _parseDate) DateTime? aired,
      String? synopsis,
      String? background,
      String? season,
      int? year,
      @JsonKey(name: 'rating') String? rating});

  @override
  $ImagesCopyWith<$Res>? get images;
}

/// @nodoc
class __$$AnimeImplCopyWithImpl<$Res>
    extends _$AnimeCopyWithImpl<$Res, _$AnimeImpl>
    implements _$$AnimeImplCopyWith<$Res> {
  __$$AnimeImplCopyWithImpl(
      _$AnimeImpl _value, $Res Function(_$AnimeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? malId = null,
    Object? title = freezed,
    Object? titleEnglish = freezed,
    Object? images = freezed,
    Object? airing = freezed,
    Object? score = freezed,
    Object? scoredBy = freezed,
    Object? rank = freezed,
    Object? members = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? episodes = freezed,
    Object? aired = freezed,
    Object? synopsis = freezed,
    Object? background = freezed,
    Object? season = freezed,
    Object? year = freezed,
    Object? rating = freezed,
  }) {
    return _then(_$AnimeImpl(
      malId: null == malId
          ? _value.malId
          : malId // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      titleEnglish: freezed == titleEnglish
          ? _value.titleEnglish
          : titleEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Images?,
      airing: freezed == airing
          ? _value.airing
          : airing // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      scoredBy: freezed == scoredBy
          ? _value.scoredBy
          : scoredBy // ignore: cast_nullable_to_non_nullable
              as int?,
      rank: freezed == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as int?,
      aired: freezed == aired
          ? _value.aired
          : aired // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      synopsis: freezed == synopsis
          ? _value.synopsis
          : synopsis // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimeImpl implements _Anime {
  const _$AnimeImpl(
      {required this.malId,
      this.title,
      @JsonKey(name: 'title_english') this.titleEnglish,
      this.images,
      @JsonKey(name: 'airing') this.airing,
      this.score,
      @JsonKey(name: 'scored_by') this.scoredBy,
      this.rank,
      this.members,
      this.type,
      this.status,
      @JsonKey(name: 'episodes') this.episodes,
      @JsonKey(name: 'aired', fromJson: _parseDate) this.aired,
      this.synopsis,
      this.background,
      this.season,
      this.year,
      @JsonKey(name: 'rating') this.rating});

  factory _$AnimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnimeImplFromJson(json);

  /// 动漫 ID
  @override
  final int malId;

  /// 动漫标题
  @override
  final String? title;

  /// 英文标题
  @override
  @JsonKey(name: 'title_english')
  final String? titleEnglish;

  /// 图片 URL
  @override
  final Images? images;

  /// 是否正在播出
  @override
  @JsonKey(name: 'airing')
  final bool? airing;

  /// 评分
  @override
  final double? score;

  /// 评分人数
  @override
  @JsonKey(name: 'scored_by')
  final int? scoredBy;

  /// 排名
  @override
  final int? rank;

  /// 成员数
  @override
  final int? members;

  /// 类型 (TV, Movie, OVA, etc.)
  @override
  final String? type;

  /// 状态 (Finished Airing, Currently Airing, Not yet aired)
  @override
  final String? status;

  /// 播放集数
  @override
  @JsonKey(name: 'episodes')
  final int? episodes;

  /// 开始日期
  @override
  @JsonKey(name: 'aired', fromJson: _parseDate)
  final DateTime? aired;

  /// 简介
  @override
  final String? synopsis;

  /// 背景
  @override
  final String? background;

  /// 季节
  @override
  final String? season;

  /// 年份
  @override
  final int? year;

  /// 评分等级
  @override
  @JsonKey(name: 'rating')
  final String? rating;

  @override
  String toString() {
    return 'Anime(malId: $malId, title: $title, titleEnglish: $titleEnglish, images: $images, airing: $airing, score: $score, scoredBy: $scoredBy, rank: $rank, members: $members, type: $type, status: $status, episodes: $episodes, aired: $aired, synopsis: $synopsis, background: $background, season: $season, year: $year, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimeImpl &&
            (identical(other.malId, malId) || other.malId == malId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleEnglish, titleEnglish) ||
                other.titleEnglish == titleEnglish) &&
            (identical(other.images, images) || other.images == images) &&
            (identical(other.airing, airing) || other.airing == airing) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.scoredBy, scoredBy) ||
                other.scoredBy == scoredBy) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.members, members) || other.members == members) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.episodes, episodes) ||
                other.episodes == episodes) &&
            (identical(other.aired, aired) || other.aired == aired) &&
            (identical(other.synopsis, synopsis) ||
                other.synopsis == synopsis) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      malId,
      title,
      titleEnglish,
      images,
      airing,
      score,
      scoredBy,
      rank,
      members,
      type,
      status,
      episodes,
      aired,
      synopsis,
      background,
      season,
      year,
      rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimeImplCopyWith<_$AnimeImpl> get copyWith =>
      __$$AnimeImplCopyWithImpl<_$AnimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimeImplToJson(
      this,
    );
  }
}

abstract class _Anime implements Anime {
  const factory _Anime(
      {required final int malId,
      final String? title,
      @JsonKey(name: 'title_english') final String? titleEnglish,
      final Images? images,
      @JsonKey(name: 'airing') final bool? airing,
      final double? score,
      @JsonKey(name: 'scored_by') final int? scoredBy,
      final int? rank,
      final int? members,
      final String? type,
      final String? status,
      @JsonKey(name: 'episodes') final int? episodes,
      @JsonKey(name: 'aired', fromJson: _parseDate) final DateTime? aired,
      final String? synopsis,
      final String? background,
      final String? season,
      final int? year,
      @JsonKey(name: 'rating') final String? rating}) = _$AnimeImpl;

  factory _Anime.fromJson(Map<String, dynamic> json) = _$AnimeImpl.fromJson;

  @override

  /// 动漫 ID
  int get malId;
  @override

  /// 动漫标题
  String? get title;
  @override

  /// 英文标题
  @JsonKey(name: 'title_english')
  String? get titleEnglish;
  @override

  /// 图片 URL
  Images? get images;
  @override

  /// 是否正在播出
  @JsonKey(name: 'airing')
  bool? get airing;
  @override

  /// 评分
  double? get score;
  @override

  /// 评分人数
  @JsonKey(name: 'scored_by')
  int? get scoredBy;
  @override

  /// 排名
  int? get rank;
  @override

  /// 成员数
  int? get members;
  @override

  /// 类型 (TV, Movie, OVA, etc.)
  String? get type;
  @override

  /// 状态 (Finished Airing, Currently Airing, Not yet aired)
  String? get status;
  @override

  /// 播放集数
  @JsonKey(name: 'episodes')
  int? get episodes;
  @override

  /// 开始日期
  @JsonKey(name: 'aired', fromJson: _parseDate)
  DateTime? get aired;
  @override

  /// 简介
  String? get synopsis;
  @override

  /// 背景
  String? get background;
  @override

  /// 季节
  String? get season;
  @override

  /// 年份
  int? get year;
  @override

  /// 评分等级
  @JsonKey(name: 'rating')
  String? get rating;
  @override
  @JsonKey(ignore: true)
  _$$AnimeImplCopyWith<_$AnimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return _Images.fromJson(json);
}

/// @nodoc
mixin _$Images {
  /// JPG 格式图片
  Jpg? get jpg => throw _privateConstructorUsedError;

  /// WebP 格式图片
  WebP? get webp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImagesCopyWith<Images> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagesCopyWith<$Res> {
  factory $ImagesCopyWith(Images value, $Res Function(Images) then) =
      _$ImagesCopyWithImpl<$Res, Images>;
  @useResult
  $Res call({Jpg? jpg, WebP? webp});

  $JpgCopyWith<$Res>? get jpg;
  $WebPCopyWith<$Res>? get webp;
}

/// @nodoc
class _$ImagesCopyWithImpl<$Res, $Val extends Images>
    implements $ImagesCopyWith<$Res> {
  _$ImagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jpg = freezed,
    Object? webp = freezed,
  }) {
    return _then(_value.copyWith(
      jpg: freezed == jpg
          ? _value.jpg
          : jpg // ignore: cast_nullable_to_non_nullable
              as Jpg?,
      webp: freezed == webp
          ? _value.webp
          : webp // ignore: cast_nullable_to_non_nullable
              as WebP?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JpgCopyWith<$Res>? get jpg {
    if (_value.jpg == null) {
      return null;
    }

    return $JpgCopyWith<$Res>(_value.jpg!, (value) {
      return _then(_value.copyWith(jpg: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WebPCopyWith<$Res>? get webp {
    if (_value.webp == null) {
      return null;
    }

    return $WebPCopyWith<$Res>(_value.webp!, (value) {
      return _then(_value.copyWith(webp: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImagesImplCopyWith<$Res> implements $ImagesCopyWith<$Res> {
  factory _$$ImagesImplCopyWith(
          _$ImagesImpl value, $Res Function(_$ImagesImpl) then) =
      __$$ImagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Jpg? jpg, WebP? webp});

  @override
  $JpgCopyWith<$Res>? get jpg;
  @override
  $WebPCopyWith<$Res>? get webp;
}

/// @nodoc
class __$$ImagesImplCopyWithImpl<$Res>
    extends _$ImagesCopyWithImpl<$Res, _$ImagesImpl>
    implements _$$ImagesImplCopyWith<$Res> {
  __$$ImagesImplCopyWithImpl(
      _$ImagesImpl _value, $Res Function(_$ImagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jpg = freezed,
    Object? webp = freezed,
  }) {
    return _then(_$ImagesImpl(
      jpg: freezed == jpg
          ? _value.jpg
          : jpg // ignore: cast_nullable_to_non_nullable
              as Jpg?,
      webp: freezed == webp
          ? _value.webp
          : webp // ignore: cast_nullable_to_non_nullable
              as WebP?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImagesImpl implements _Images {
  const _$ImagesImpl({this.jpg, this.webp});

  factory _$ImagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImagesImplFromJson(json);

  /// JPG 格式图片
  @override
  final Jpg? jpg;

  /// WebP 格式图片
  @override
  final WebP? webp;

  @override
  String toString() {
    return 'Images(jpg: $jpg, webp: $webp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImagesImpl &&
            (identical(other.jpg, jpg) || other.jpg == jpg) &&
            (identical(other.webp, webp) || other.webp == webp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, jpg, webp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImagesImplCopyWith<_$ImagesImpl> get copyWith =>
      __$$ImagesImplCopyWithImpl<_$ImagesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImagesImplToJson(
      this,
    );
  }
}

abstract class _Images implements Images {
  const factory _Images({final Jpg? jpg, final WebP? webp}) = _$ImagesImpl;

  factory _Images.fromJson(Map<String, dynamic> json) = _$ImagesImpl.fromJson;

  @override

  /// JPG 格式图片
  Jpg? get jpg;
  @override

  /// WebP 格式图片
  WebP? get webp;
  @override
  @JsonKey(ignore: true)
  _$$ImagesImplCopyWith<_$ImagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Jpg _$JpgFromJson(Map<String, dynamic> json) {
  return _Jpg.fromJson(json);
}

/// @nodoc
mixin _$Jpg {
  /// 图片 URL
  String? get image_url => throw _privateConstructorUsedError;

  /// 小尺寸图片 URL
  String? get small_image_url => throw _privateConstructorUsedError;

  /// 大尺寸图片 URL
  String? get large_image_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JpgCopyWith<Jpg> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JpgCopyWith<$Res> {
  factory $JpgCopyWith(Jpg value, $Res Function(Jpg) then) =
      _$JpgCopyWithImpl<$Res, Jpg>;
  @useResult
  $Res call(
      {String? image_url, String? small_image_url, String? large_image_url});
}

/// @nodoc
class _$JpgCopyWithImpl<$Res, $Val extends Jpg> implements $JpgCopyWith<$Res> {
  _$JpgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image_url = freezed,
    Object? small_image_url = freezed,
    Object? large_image_url = freezed,
  }) {
    return _then(_value.copyWith(
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      small_image_url: freezed == small_image_url
          ? _value.small_image_url
          : small_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      large_image_url: freezed == large_image_url
          ? _value.large_image_url
          : large_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JpgImplCopyWith<$Res> implements $JpgCopyWith<$Res> {
  factory _$$JpgImplCopyWith(_$JpgImpl value, $Res Function(_$JpgImpl) then) =
      __$$JpgImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? image_url, String? small_image_url, String? large_image_url});
}

/// @nodoc
class __$$JpgImplCopyWithImpl<$Res> extends _$JpgCopyWithImpl<$Res, _$JpgImpl>
    implements _$$JpgImplCopyWith<$Res> {
  __$$JpgImplCopyWithImpl(_$JpgImpl _value, $Res Function(_$JpgImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image_url = freezed,
    Object? small_image_url = freezed,
    Object? large_image_url = freezed,
  }) {
    return _then(_$JpgImpl(
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      small_image_url: freezed == small_image_url
          ? _value.small_image_url
          : small_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      large_image_url: freezed == large_image_url
          ? _value.large_image_url
          : large_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JpgImpl implements _Jpg {
  const _$JpgImpl({this.image_url, this.small_image_url, this.large_image_url});

  factory _$JpgImpl.fromJson(Map<String, dynamic> json) =>
      _$$JpgImplFromJson(json);

  /// 图片 URL
  @override
  final String? image_url;

  /// 小尺寸图片 URL
  @override
  final String? small_image_url;

  /// 大尺寸图片 URL
  @override
  final String? large_image_url;

  @override
  String toString() {
    return 'Jpg(image_url: $image_url, small_image_url: $small_image_url, large_image_url: $large_image_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JpgImpl &&
            (identical(other.image_url, image_url) ||
                other.image_url == image_url) &&
            (identical(other.small_image_url, small_image_url) ||
                other.small_image_url == small_image_url) &&
            (identical(other.large_image_url, large_image_url) ||
                other.large_image_url == large_image_url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, image_url, small_image_url, large_image_url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JpgImplCopyWith<_$JpgImpl> get copyWith =>
      __$$JpgImplCopyWithImpl<_$JpgImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JpgImplToJson(
      this,
    );
  }
}

abstract class _Jpg implements Jpg {
  const factory _Jpg(
      {final String? image_url,
      final String? small_image_url,
      final String? large_image_url}) = _$JpgImpl;

  factory _Jpg.fromJson(Map<String, dynamic> json) = _$JpgImpl.fromJson;

  @override

  /// 图片 URL
  String? get image_url;
  @override

  /// 小尺寸图片 URL
  String? get small_image_url;
  @override

  /// 大尺寸图片 URL
  String? get large_image_url;
  @override
  @JsonKey(ignore: true)
  _$$JpgImplCopyWith<_$JpgImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebP _$WebPFromJson(Map<String, dynamic> json) {
  return _WebP.fromJson(json);
}

/// @nodoc
mixin _$WebP {
  /// 图片 URL
  String? get image_url => throw _privateConstructorUsedError;

  /// 小尺寸图片 URL
  String? get small_image_url => throw _privateConstructorUsedError;

  /// 大尺寸图片 URL
  String? get large_image_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebPCopyWith<WebP> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebPCopyWith<$Res> {
  factory $WebPCopyWith(WebP value, $Res Function(WebP) then) =
      _$WebPCopyWithImpl<$Res, WebP>;
  @useResult
  $Res call(
      {String? image_url, String? small_image_url, String? large_image_url});
}

/// @nodoc
class _$WebPCopyWithImpl<$Res, $Val extends WebP>
    implements $WebPCopyWith<$Res> {
  _$WebPCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image_url = freezed,
    Object? small_image_url = freezed,
    Object? large_image_url = freezed,
  }) {
    return _then(_value.copyWith(
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      small_image_url: freezed == small_image_url
          ? _value.small_image_url
          : small_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      large_image_url: freezed == large_image_url
          ? _value.large_image_url
          : large_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebPImplCopyWith<$Res> implements $WebPCopyWith<$Res> {
  factory _$$WebPImplCopyWith(
          _$WebPImpl value, $Res Function(_$WebPImpl) then) =
      __$$WebPImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? image_url, String? small_image_url, String? large_image_url});
}

/// @nodoc
class __$$WebPImplCopyWithImpl<$Res>
    extends _$WebPCopyWithImpl<$Res, _$WebPImpl>
    implements _$$WebPImplCopyWith<$Res> {
  __$$WebPImplCopyWithImpl(_$WebPImpl _value, $Res Function(_$WebPImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image_url = freezed,
    Object? small_image_url = freezed,
    Object? large_image_url = freezed,
  }) {
    return _then(_$WebPImpl(
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      small_image_url: freezed == small_image_url
          ? _value.small_image_url
          : small_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
      large_image_url: freezed == large_image_url
          ? _value.large_image_url
          : large_image_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebPImpl implements _WebP {
  const _$WebPImpl(
      {this.image_url, this.small_image_url, this.large_image_url});

  factory _$WebPImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebPImplFromJson(json);

  /// 图片 URL
  @override
  final String? image_url;

  /// 小尺寸图片 URL
  @override
  final String? small_image_url;

  /// 大尺寸图片 URL
  @override
  final String? large_image_url;

  @override
  String toString() {
    return 'WebP(image_url: $image_url, small_image_url: $small_image_url, large_image_url: $large_image_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebPImpl &&
            (identical(other.image_url, image_url) ||
                other.image_url == image_url) &&
            (identical(other.small_image_url, small_image_url) ||
                other.small_image_url == small_image_url) &&
            (identical(other.large_image_url, large_image_url) ||
                other.large_image_url == large_image_url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, image_url, small_image_url, large_image_url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebPImplCopyWith<_$WebPImpl> get copyWith =>
      __$$WebPImplCopyWithImpl<_$WebPImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebPImplToJson(
      this,
    );
  }
}

abstract class _WebP implements WebP {
  const factory _WebP(
      {final String? image_url,
      final String? small_image_url,
      final String? large_image_url}) = _$WebPImpl;

  factory _WebP.fromJson(Map<String, dynamic> json) = _$WebPImpl.fromJson;

  @override

  /// 图片 URL
  String? get image_url;
  @override

  /// 小尺寸图片 URL
  String? get small_image_url;
  @override

  /// 大尺寸图片 URL
  String? get large_image_url;
  @override
  @JsonKey(ignore: true)
  _$$WebPImplCopyWith<_$WebPImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
