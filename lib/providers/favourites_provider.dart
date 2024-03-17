import 'package:flutter/material.dart';
import 'package:oyun_katalog/models/game_names.dart';

class FavoritesProvider extends ChangeNotifier{
  final List<Game> _favgames = [];
  List<Game> get games => _favgames;
  
  //method to add a game to favourites
  void toggle(Game game){
    final isLiked = _favgames.contains(game);
    if (isLiked){
      _favgames.remove(game);
    }else{
      _favgames.add(game);
    }
    notifyListeners();
  }

  bool isLiked(Game game){
    final isLiked = _favgames.contains(game);
    return isLiked;
  }
}