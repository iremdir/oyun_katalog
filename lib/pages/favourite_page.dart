// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oyun_katalog/pages/game_page.dart';
import 'package:oyun_katalog/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

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
    FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context);
    final games = favoritesProvider.games;
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'),automaticallyImplyLeading: false),
      bottomNavigationBar: BottomNavigationBarSettings(currentPageIndex: 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        
        Expanded(
          child: games.isEmpty ? const Text("No favourites!") :
          ListView.builder(
            itemCount: games.length,     
            itemBuilder: (context, index) {  
              final game = games[index];
              final gameName = game.name;  
              final metacriticPoint = game.metacriticScore;
              final backgroundImage = game.backgroundImage;
              final gameGenre = game.gameGenre;
              return  GameCard(gameName: gameName, metacriticPoint: metacriticPoint, gameGenre: gameGenre, backgroundImage: backgroundImage, game: game);
          },),

        ),
        ],
      ),
    );  
  }
}