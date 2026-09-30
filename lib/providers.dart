import 'package:flutter_riverpod/legacy.dart';
import 'package:movies/network/anilist_api_service.dart';
import 'package:movies/network/bangumi_api_service.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:movies/utils/prefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'providers.g.dart';

/// 路由提供者
@Riverpod(keepAlive: true)
AppRouter appRouter(Ref ref) => AppRouter();

/// Bangumi API 服务提供者
/// 提供 BangumiApiService 实例（主数据源）
@Riverpod(keepAlive: true)
BangumiApiService bangumiApiService(Ref ref) => BangumiApiService();

/// AniList API 服务提供者
/// 提供 AniListApiService 实例（补充横幅与 PV）
@Riverpod(keepAlive: true)
AniListApiService anilistApiService(Ref ref) => AniListApiService();

/// SharedPreferences 提供者
/// 异步加载本地存储实例
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPrefs(Ref ref) => SharedPreferences.getInstance();

/// Prefs 提供者
/// 封装 SharedPreferences，提供类型安全的存储方法
@Riverpod(keepAlive: true)
Future<Prefs> prefs(Ref ref) async {
  final sharedPrefs = await ref.read(sharedPrefsProvider.future);
  return Prefs(sharedPrefs);
}

/// 动漫视图模型提供者
/// 异步加载，等待 setup 完成后返回 AnimeViewModel
@Riverpod(keepAlive: true)
Future<AnimeViewModel> animeViewModel(Ref ref) async {
  final model = AnimeViewModel(
    bangumiApiService: ref.read(bangumiApiServiceProvider),
    aniListApiService: ref.read(anilistApiServiceProvider),
    prefs: await ref.read(prefsProvider.future),
  );
  await model.setup();
  return model;
}

/// Hero 动画标签状态提供者
/// 用于在不同页面间传递 Hero 动画的唯一标签
final heroTagProvider = StateProvider<String>((ref) {
  return '';
});
