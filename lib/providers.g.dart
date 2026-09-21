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

/// 动漫 API 服务提供者
/// 提供 AnimeAPIService 实例

@ProviderFor(animeAPIService)
final animeAPIServiceProvider = AnimeAPIServiceProvider._();

/// 动漫 API 服务提供者
/// 提供 AnimeAPIService 实例

final class AnimeAPIServiceProvider
    extends
        $FunctionalProvider<AnimeAPIService, AnimeAPIService, AnimeAPIService>
    with $Provider<AnimeAPIService> {
  /// 动漫 API 服务提供者
  /// 提供 AnimeAPIService 实例
  AnimeAPIServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animeAPIServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$animeAPIServiceHash();

  @$internal
  @override
  $ProviderElement<AnimeAPIService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnimeAPIService create(Ref ref) {
    return animeAPIService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnimeAPIService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnimeAPIService>(value),
    );
  }
}

String _$animeAPIServiceHash() => r'a48d1092bec3dfb9ea9a2f42f5b0d6c4c53e349f';

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

String _$animeViewModelHash() => r'2dfe81fb83245799be87617a08a816708a72694d';
