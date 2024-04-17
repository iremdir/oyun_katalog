// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:oyun_katalog/models/game_details.dart';
import 'package:oyun_katalog/models/game_names.dart';
import 'package:oyun_katalog/pages/game_page.dart';
import 'package:oyun_katalog/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

class GameDetailPage extends StatelessWidget {
  final Game game;
  final String backgroundImage;
  final String gameName;
  const GameDetailPage(
      {super.key,
      required this.backgroundImage,
      required this.gameName,
      required this.game});

  @override
  Widget build(BuildContext context) {
    FavoritesProvider favoritesProvider =
        Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePageView(),
                    ));
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.blue,
            ),
            Text(
              "Games",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              color: Colors.blue,
              onPressed: () {
                favoritesProvider.toggle(game);
              },
              icon: favoritesProvider.isLiked(game)
                  ? const Icon(Icons.favorite, color: Colors.blue)
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.blue,
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(backgroundImage),
              Text(
                gameName,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
          Container(
            child: Column(
              children: [Text("Game Desription"), Text("description")],
            ),
          ),
          Divider(),
        ]),
      ),
    );
  }
}
