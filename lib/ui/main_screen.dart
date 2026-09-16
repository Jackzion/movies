import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/theme/theme.dart';

@RoutePage(name: 'MainRoute')
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: screenBackground,
      routes: const [
        HomeRoute(),
        GenreRoute(),
        FavoriteRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => buildBottomBar(tabsRouter),
    );
  }

  Widget buildBottomBar(TabsRouter tabsRouter) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Symbols.genres), label: 'Genre'),
        NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
      ],
      selectedIndex: tabsRouter.activeIndex,
      onDestinationSelected: (navIndex) {
        tabsRouter.setActiveIndex(navIndex);
      },
    );
  }
}
