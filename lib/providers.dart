import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movies/data/database/drift/drift_database.dart';
import 'package:movies/data/database/models/database_interface.dart';
import 'package:movies/data/database/repositories/rules_repository.dart';
import 'package:movies/network/anilist_api_service.dart';
import 'package:movies/network/bangumi_api_service.dart';
import 'package:movies/network/rule_engine.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/services/video_source/webview_video_source_service.dart';
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

/// Drift 数据库提供者
@Riverpod(keepAlive: true)
Future<IDatabase> driftDatabase(Ref ref) async {
  return DriftDatabase();
}

/// 动漫视图模型提供者
/// 异步加载，等待 setup 完成后返回 AnimeViewModel
@Riverpod(keepAlive: true)
Future<AnimeViewModel> animeViewModel(Ref ref) async {
  final model = AnimeViewModel(
    bangumiApiService: ref.read(bangumiApiServiceProvider),
    aniListApiService: ref.read(anilistApiServiceProvider),
    prefs: await ref.read(prefsProvider.future),
    database: await ref.read(driftDatabaseProvider.future),
  );
  await model.setup();
  return model;
}

/// Hero 动画标签状态提供者
/// 用于在不同页面间传递 Hero 动画的唯一标签
final heroTagProvider = StateProvider<String>((ref) {
  return '';
});

/// 主框架导航下标（Home / Genre / Favorites）
final currentNavIndexProvider = StateProvider<int>((ref) {
  return 0;
});

/// 跨页面搜索关键字
/// SearchDialog 写入，GenreScreen 监听后触发搜索
final searchTextProvider = StateProvider<String>((ref) {
  return '';
});

/// 无头 WebView 取流服务（应用级单例）
/// keepAlive: 整个 App 生命周期内复用同一个 HeadlessWebview
@Riverpod(keepAlive: true)
WebviewVideoSourceService webviewVideoSourceService(Ref ref){
  final service = WebviewVideoSourceService();
  // provider 被销毁时（极少见，keepAlive 一般活到 App 退出）顺带销毁 WebView
  ref.onDispose(() {
    // fire-and-forget：dispose 是异步的，不阻塞销毁流程
    service.dispose();
  });
  return service;
}

/// 规则仓库：应用内单例
/// 提供 RulesRepository 实例（负责规则数据的读写）
@Riverpod(keepAlive: true)
Future<RulesRepository> rulesRepository(Ref ref) async {
  final prefs = await ref.read(prefsProvider.future);
  return RulesRepository(prefs);
}

/// 规则引擎（无状态；Dio 复用）
@Riverpod(keepAlive: true)
RuleEngine ruleEngine(Ref ref) => RuleEngine();