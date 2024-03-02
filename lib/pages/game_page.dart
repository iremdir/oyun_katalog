import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GamePageView extends StatefulWidget {
  const GamePageView({super.key});

  @override
  State<GamePageView> createState() => _GamePageViewState();
}

class _GamePageViewState extends State<GamePageView> {
  
  List<dynamic> games = [];
  
  
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
        
        
        
        const Padding(padding: EdgeInsets.all(8),
        child: TextField(
          
          decoration: InputDecoration(
            filled: false,
            fillColor: Color.fromARGB(255, 98, 92, 92),
            
            hintText: 'Search for the games',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),)),),
        
        
        Expanded(
          child: ListView.builder(
            itemCount: games.length,     
            itemBuilder: (context, index) {  
              final user = games[index];
              final gameName = user['name'];  
              final metacriticPoint = user['metacritic'];
              final backgroundImage = user['background_image'];
              final gameGenre = user['genres'][0]['name'];
              return  ListTile(
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
          },),
        )
      ],
      
      )
      
      
    );

  }
  
  
  
  void fetchGames() async{
    const url = 'https://api.rawg.io/api/games?key=3be8af6ebf124ffe81d90f514e59856c&page_size=10&page=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      games = json['results'];
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