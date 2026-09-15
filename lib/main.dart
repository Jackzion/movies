import 'package:flutter/material.dart';
import 'package:movies/ui/main_screen.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  // pod_player 在 Windows/Linux/macOS 底层用 media_kit,
  // 必须显式初始化,否则视频播放会直接报 "Error while playing video"
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
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
