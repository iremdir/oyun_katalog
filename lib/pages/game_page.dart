import 'dart:async';

import 'package:flutter/material.dart';

import 'package:oyun_katalog/models/game_names.dart';
import 'package:oyun_katalog/services/games_api.dart';

class GamePageView extends StatefulWidget {
  const GamePageView({super.key});

  @override
  State<GamePageView> createState() => _GamePageViewState();
}

class _GamePageViewState extends State<GamePageView> {
  
  List<Game> games = [];
  List<Game> displayGames = [];
  
  
  
  @override
  void initState(){
    super.initState();
    fetchGames(); //asking the user info from the api
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //floatingActionButton: FloatingActionButton(onPressed: fetchgames),
      body:   Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        const SizedBox(height: 20,),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text('Games',style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
          ),
        ),
        
        
        
         Padding(padding: const EdgeInsets.all(8),
        child: TextField(
          onChanged:(value) => updateList(value),
          decoration: const InputDecoration(
            filled: false,
            fillColor: Color.fromARGB(255, 98, 92, 92),
            
            hintText: 'Search for the games',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),)),),
        
        
        Expanded(
          
          child: displayGames.isEmpty ? const Text('No results found') :
          ListView.builder(
            itemCount: displayGames.length,     
            itemBuilder: (context, index) {  
              final game = displayGames[index];
              final gameName = game.name;  
              final metacriticPoint = game.metacriticScore;
              final backgroundImage = game.backgroundImage;
              final gameGenre = game.gameGenre;
              return  ListTile(
                title: Text(gameName),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32,),
                    Align(alignment:Alignment.centerLeft, child: Text('metacritic: ${metacriticPoint.toString()}')),
                    Align(alignment: Alignment.centerLeft,child: Text(gameGenre),)
                  ],
                ),
                leading: Image.network(backgroundImage),
                
              );
          },),
        )
      ],
      
      )
      
      
    );

  }
  
  
  Future<void> fetchGames() async{
    final response = await GamesApi.fetchGames();
    setState(() {
      
      games = response;
      displayGames = List.from(games);
   });
  }
  
  void updateList(String value){
    setState(() {
      
      displayGames = games.where((element) {
        final String name = element.name.toString().toLowerCase() ?? ' '; 
        final String genre = element.gameGenre.toString().toLowerCase() ?? ' ';
        
        return name.contains(value.toLowerCase()) || genre.contains(value.toLowerCase());
      }).toList();
      
    });
    
  }

}


class SearchBar extends StatefulWidget {
 
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  
  
  String query = '';
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return  const Padding(padding: EdgeInsets.all(8),
        child: TextField(
          
          decoration: InputDecoration(
            filled: false,
            fillColor: Color.fromARGB(255, 98, 92, 92),
            
            hintText: 'Search for the games',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),)),);
  }
}

class GameCard extends StatelessWidget {
  
  String gameName;
  String metacriticPoint;
  String gameGenre;

  
  GameCard({super.key,required this.gameName, 
  required this.metacriticPoint,
  required this.gameGenre});

  @override
  Widget build(BuildContext context) {
    
    
    return ListTile(
        title: Text(gameName),
        subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 32,),
          Align(alignment:Alignment.centerLeft, child: Text(metacriticPoint.toString())),
          Align(alignment: Alignment.centerLeft,child: Text(gameGenre),)
        ],
      )
                
    );
  }
}