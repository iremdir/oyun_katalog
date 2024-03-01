import 'package:flutter/material.dart';
import 'package:oyun_katalog/pages/game_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: GamePageView(),
        ),
      ),
    );
  }
}
