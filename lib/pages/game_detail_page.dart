// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:oyun_katalog/models/game_details.dart';
import 'package:oyun_katalog/models/game_names.dart';
import 'package:oyun_katalog/pages/game_page.dart';
import 'package:oyun_katalog/providers/favourites_provider.dart';
import 'package:provider/provider.dart';
import 'package:oyun_katalog/services/games_api.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailPage extends StatefulWidget {
  final Game game;
  final String backgroundImage;
  final String gameName;
  const GameDetailPage(
      {super.key,
      required this.backgroundImage,
      required this.gameName,
      required this.game});

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  Map<String, dynamic> map = {};
  Future<void> fetchDetailGames() async {
    final response = await GamesApi.fetchDetailGames(widget.game.Id);
    setState(() {
      map = response;
    });
  }

  @override
  void initState() {
    fetchDetailGames();
  }

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
                favoritesProvider.toggle(widget.game);
              },
              icon: favoritesProvider.isLiked(widget.game)
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
              Image.network(widget.backgroundImage),
              Text(
                widget.gameName,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
          Container(
            child: Column(
              children: [Text("Game Desription"), Text(map["description"])],
            ),
          ),
          Divider(),
          TextButton(
              style: ButtonStyle(alignment: Alignment.centerLeft),
              onPressed: () {
                _launchURL("http://make-everything-ok.com/");
              },
              child: Text("Visit reddit")),
          Divider(),
          TextButton(
              style: ButtonStyle(alignment: Alignment.centerLeft),
              onPressed: () {
                _launchURL("https://www.trashloop.com/");
              },
              child: Text(
                "Visit website",
                style: TextStyle(),
              ))
        ]),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    await launch(url);
  }
}
