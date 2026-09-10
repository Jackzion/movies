import 'package:flutter/material.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF111111),
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'NOW PLAYING',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            HomeScreenImage(),
          ],
        ),
      ),
    );
  }
}
