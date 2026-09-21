import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movies/network/anime_api_service.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/anime_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

/// 路由提供者
@Riverpod(keepAlive: true)
AppRouter appRouter(Ref ref) => AppRouter();

/// 动漫 API 服务提供者
/// 提供 AnimeAPIService 实例
@Riverpod(keepAlive: true)
AnimeAPIService animeAPIService(Ref ref) => AnimeAPIService();

/// 动漫视图模型提供者
/// 异步加载，等待 setup 完成后返回 AnimeViewModel
@Riverpod(keepAlive: true)
Future<AnimeViewModel> animeViewModel(Ref ref) async {
  final model = AnimeViewModel(
    animeAPIService: ref.read(animeAPIServiceProvider),
  );
  await model.setup();
  return model;
}

/// Hero 动画标签状态提供者
/// 用于在不同页面间传递 Hero 动画的唯一标签
final heroTagProvider = StateProvider<String>((ref) {
  return '';
});
