import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oyun_katalog/models/game_details.dart';

import 'package:oyun_katalog/models/game_names.dart';
import 'package:oyun_katalog/pages/favourite_page.dart';
import 'package:oyun_katalog/pages/game_detail.dart';
import 'package:oyun_katalog/services/games_api.dart';

class GamePageView extends StatefulWidget {
  const GamePageView({super.key});

  @override
  State<GamePageView> createState() => _GamePageViewState();
}

class _GamePageViewState extends State<GamePageView> {
  List<Game> games = [];
  List<Game> displayGames = [];
  final int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchGames(); //asking the user info from the api
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBarSettings(
          currentPageIndex: _MyIcons.gamesicon.index),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Games',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
                onChanged: (value) => updateList(value),
                decoration: const InputDecoration(
                  filled: false,
                  fillColor: Color.fromARGB(255, 98, 92, 92),
                  hintText: 'Search for the games',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                )),
          ),
          Expanded(
            child: displayGames.isEmpty
                ? const Text('No results found')
                : ListView.builder(
                    itemCount: displayGames.length,
                    itemBuilder: (context, index) {
                      final game = displayGames[index];
                      final gameName = game.name;
                      final metacriticPoint = game.metacriticScore;
                      final backgroundImage = game.backgroundImage;
                      final gameGenre = game.gameGenre;
                      return GameCard(
                          gameName: gameName,
                          metacriticPoint: metacriticPoint,
                          gameGenre: gameGenre,
                          backgroundImage: backgroundImage,
                          game: game);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchGames() async {
    final response = await GamesApi.fetchGames();
    setState(() {
      games = response;
      displayGames = List.from(games);
    });
  }

  void updateList(String value) {
    setState(() {
      displayGames = games.where((element) {
        final String name = element.name.toString().toLowerCase();
        final String genre = element.gameGenre.toString().toLowerCase();

        return name.contains(value.toLowerCase()) ||
            genre.contains(value.toLowerCase());
      }).toList();
    });
  }
}

enum _MyIcons { gamesicon, favouritesicon }

@override
Widget build(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(8),
    child: TextField(
        decoration: InputDecoration(
      filled: false,
      fillColor: Color.fromARGB(255, 98, 92, 92),
      hintText: 'Search for the games',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.search),
    )),
  );
}

class GameCard extends StatelessWidget {
  Game game;
  String gameName;
  int metacriticPoint;
  String gameGenre;
  String backgroundImage;

  GameCard({
    super.key,
    required this.gameName,
    required this.metacriticPoint,
    required this.gameGenre,
    required this.backgroundImage,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(gameName),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 32,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(metacriticPoint.toString())),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(gameGenre),
          )
        ],
      ),
      leading: Image.network(backgroundImage),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GameDetailPage(
                    backgroundImage: backgroundImage,
                    gameName: gameName,
                    game: game)));
      },
    );
  }
}

class BottomNavigationBarSettings extends StatefulWidget {
  int currentPageIndex;
  BottomNavigationBarSettings({super.key, required this.currentPageIndex});

  @override
  State<BottomNavigationBarSettings> createState() =>
      _BottomNavigationBarSettingsState();
}

class _BottomNavigationBarSettingsState
    extends State<BottomNavigationBarSettings> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (value) {
          if (value == _MyIcons.gamesicon.index) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const GamePageView())));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const FavouriteGamesView())));
          }
          setState(() {
            widget.currentPageIndex = value;
          });
        },
        currentIndex: widget.currentPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Games'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ]);
  }
}
