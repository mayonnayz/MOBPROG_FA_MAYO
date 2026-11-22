
import 'package:fa5_creativity_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BiomeMatch());
}

class BiomeMatch extends StatelessWidget {
  const BiomeMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Match-a-Biome',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF30251D),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
