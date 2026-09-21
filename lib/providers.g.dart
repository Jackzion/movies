// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'42599edccdcfb58d05fc5c5c1776f848db2a5b20';

/// 路由提供者
///
/// Copied from [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = Provider<AppRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRouterRef = ProviderRef<AppRouter>;
String _$animeViewModelHash() => r'dd8a950f5241b83cb740d1cba16d6f0ac0a34021';

/// 动漫视图模型提供者
/// 异步加载，等待 setup 完成后返回 AnimeViewModel
///
/// Copied from [animeViewModel].
@ProviderFor(animeViewModel)
final animeViewModelProvider = FutureProvider<AnimeViewModel>.internal(
  animeViewModel,
  name: r'animeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$animeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnimeViewModelRef = FutureProviderRef<AnimeViewModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
