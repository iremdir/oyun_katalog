import 'package:flutter/material.dart';

class GamePageView extends StatefulWidget {
  const GamePageView({super.key});

  @override
  State<GamePageView> createState() => _GamePageViewState();
}

class _GamePageViewState extends State<GamePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        SizedBox(height: 20,),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text('Games',style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
          ),
        ),
        Padding(padding: EdgeInsets.all(8),
        child: TextField(
          
          decoration: InputDecoration(
            filled: false,
            fillColor: Color.fromARGB(255, 98, 92, 92),
            
            hintText: 'Search for the games',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),)),)
        
      ],)
      
      
    );
  }
}