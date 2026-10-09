import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/screens/favorites/favorite_screen.dart';
import 'package:movies/ui/screens/genres/genre_screen.dart';
import 'package:movies/ui/screens/home/home_screen.dart';
import 'package:movies/ui/theme/theme.dart';

/// 主框架：自适应导航
/// 小屏用底部 NavigationBar，大屏用左侧 NavigationRail
@RoutePage(name: 'MainRoute')
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  /// 缓存页面，避免切换时反复重建
  late final List<Widget> _screens = const [
    HomeScreen(),
    GenreScreen(),
    FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(currentNavIndexProvider);
    return Scaffold(
      backgroundColor: screenBackground,
      body: AdaptiveScaffold(
        selectedIndex: index,
        onSelectedIndexChange: (navIndex) {
          ref.read(currentNavIndexProvider.notifier).state = navIndex;
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Symbols.genres), label: 'Genre'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        // 小屏正文（底部导航）
        smallBody: (_) => _screens[index],
        // 中大屏正文（左侧 NavigationRail）
        body: (_) => _screens[index],
      ),
    );
  }
}
