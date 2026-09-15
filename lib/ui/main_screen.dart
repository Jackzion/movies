import 'package:flutter/material.dart';
import 'package:movies/ui/screens/home/home_screen.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:movies/ui/screens/genres/genre_screen.dart';
import 'package:movies/ui/screens/videos/video_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var index = 0;
  final List<Widget> screens = <Widget>[];

  @override
  void initState() {
    super.initState();
    screens.add(const HomeScreen());
    screens.add(const GenreScreen());
    screens.add(const VideoPage('QwW5RD02uJo'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: screens[index],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Symbols.genres), label: 'Genre'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        selectedIndex: index,
        onDestinationSelected: (int navIndex) {
          setState(() {
            index = navIndex;
          });
        },
      ),
    );
  }
}
