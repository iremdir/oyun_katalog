import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oyun_katalog/pages/game_page.dart';

class FavouriteGamesView extends StatefulWidget {
  const FavouriteGamesView({super.key});

  @override
  State<FavouriteGamesView> createState() => _FavouriteGamesViewState();
}

class _FavouriteGamesViewState extends State<FavouriteGamesView> {
  
  final int currentPage = 1;
  
  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'),automaticallyImplyLeading: false),
      bottomNavigationBar: BottomNavigationBarSettings(currentPageIndex: 1),
    );
  }
}