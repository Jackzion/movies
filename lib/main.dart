import 'package:flutter/material.dart';
import 'package:movies/ui/main_screen.dart';
import 'package:movies/ui/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: createTheme(),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
