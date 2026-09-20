import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

/// 路由提供者
@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) => AppRouter();

/// 电影视图模型提供者
/// 异步加载，等待 setup 完成后返回 MovieViewModel
@Riverpod(keepAlive: true)
Future<MovieViewModel> movieViewModel(MovieViewModelRef ref) async {
  final model = MovieViewModel();
  await model.setup();
  return model;
}

/// Hero 动画标签状态提供者
/// 用于在不同页面间传递 Hero 动画的唯一标签
final heroTagProvider = StateProvider<String>((ref) {
  return '';
});
