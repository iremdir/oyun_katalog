import 'package:flutter/material.dart';
import 'package:oyun_katalog/pages/game_page.dart';

class FavouriteGamesView extends StatelessWidget {
  const FavouriteGamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      bottomNavigationBar: const NavigationBarSettings(),
    );
  }
}