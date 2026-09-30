// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 路由提供者

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// 路由提供者

final class AppRouterProvider
    extends $FunctionalProvider<AppRouter, AppRouter, AppRouter>
    with $Provider<AppRouter> {
  /// 路由提供者
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<AppRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouter>(value),
    );
  }
}

String _$appRouterHash() => r'fc1228daa214cc1ad475cfdeafc6db36a6a237b5';

/// Bangumi API 服务提供者
/// 提供 BangumiApiService 实例（主数据源）

@ProviderFor(bangumiApiService)
final bangumiApiServiceProvider = BangumiApiServiceProvider._();

/// Bangumi API 服务提供者
/// 提供 BangumiApiService 实例（主数据源）

final class BangumiApiServiceProvider
    extends
        $FunctionalProvider<
          BangumiApiService,
          BangumiApiService,
          BangumiApiService
        >
    with $Provider<BangumiApiService> {
  /// Bangumi API 服务提供者
  /// 提供 BangumiApiService 实例（主数据源）
  BangumiApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bangumiApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bangumiApiServiceHash();

  @$internal
  @override
  $ProviderElement<BangumiApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BangumiApiService create(Ref ref) {
    return bangumiApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BangumiApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BangumiApiService>(value),
    );
  }
}

String _$bangumiApiServiceHash() => r'93c3a4e3b3235725f4f72c078252c733ea30a285';

/// AniList API 服务提供者
/// 提供 AniListApiService 实例（补充横幅与 PV）

@ProviderFor(anilistApiService)
final anilistApiServiceProvider = AnilistApiServiceProvider._();

/// AniList API 服务提供者
/// 提供 AniListApiService 实例（补充横幅与 PV）

final class AnilistApiServiceProvider
    extends
        $FunctionalProvider<
          AniListApiService,
          AniListApiService,
          AniListApiService
        >
    with $Provider<AniListApiService> {
  /// AniList API 服务提供者
  /// 提供 AniListApiService 实例（补充横幅与 PV）
  AnilistApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'anilistApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$anilistApiServiceHash();

  @$internal
  @override
  $ProviderElement<AniListApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AniListApiService create(Ref ref) {
    return anilistApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AniListApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AniListApiService>(value),
    );
  }
}

String _$anilistApiServiceHash() => r'c4c09ab7135789434efdd244b39779b776979883';

/// SharedPreferences 提供者
/// 异步加载本地存储实例

@ProviderFor(sharedPrefs)
final sharedPrefsProvider = SharedPrefsProvider._();

/// SharedPreferences 提供者
/// 异步加载本地存储实例

final class SharedPrefsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  /// SharedPreferences 提供者
  /// 异步加载本地存储实例
  SharedPrefsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPrefsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPrefsHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPrefs(ref);
  }
}

String _$sharedPrefsHash() => r'eba279b4efb2d4ef41070faedd17991e4ffd9384';

/// Prefs 提供者
/// 封装 SharedPreferences，提供类型安全的存储方法

@ProviderFor(prefs)
final prefsProvider = PrefsProvider._();

/// Prefs 提供者
/// 封装 SharedPreferences，提供类型安全的存储方法

final class PrefsProvider
    extends $FunctionalProvider<AsyncValue<Prefs>, Prefs, FutureOr<Prefs>>
    with $FutureModifier<Prefs>, $FutureProvider<Prefs> {
  /// Prefs 提供者
  /// 封装 SharedPreferences，提供类型安全的存储方法
  PrefsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefsHash();

  @$internal
  @override
  $FutureProviderElement<Prefs> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Prefs> create(Ref ref) {
    return prefs(ref);
  }
}

String _$prefsHash() => r'286d5a6891847e65488b246f20ce8495331773ef';

/// 动漫视图模型提供者
/// 异步加载，等待 setup 完成后返回 AnimeViewModel

@ProviderFor(animeViewModel)
final animeViewModelProvider = AnimeViewModelProvider._();

/// 动漫视图模型提供者
/// 异步加载，等待 setup 完成后返回 AnimeViewModel

final class AnimeViewModelProvider
    extends
        $FunctionalProvider<
          AsyncValue<AnimeViewModel>,
          AnimeViewModel,
          FutureOr<AnimeViewModel>
        >
    with $FutureModifier<AnimeViewModel>, $FutureProvider<AnimeViewModel> {
  /// 动漫视图模型提供者
  /// 异步加载，等待 setup 完成后返回 AnimeViewModel
  AnimeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animeViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$animeViewModelHash();

  @$internal
  @override
  $FutureProviderElement<AnimeViewModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AnimeViewModel> create(Ref ref) {
    return animeViewModel(ref);
  }
}

String _$animeViewModelHash() => r'05cd2534a29b8f3ad84a3f20dd2b173476f5bcf1';
