import 'package:http/http.dart' as http;
import 'package:oyun_katalog/models/game_details.dart';
import 'dart:convert';

import 'package:oyun_katalog/models/game_names.dart';

class GamesApi {
  static Future<List<Game>> fetchGames() async {
    const url =
        'https://api.rawg.io/api/games?key=3be8af6ebf124ffe81d90f514e59856c&page_size=10&page=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      return Game(
        name: e['name'],
        metacriticScore: e['metacritic'],
        backgroundImage: e['background_image'],
        gameGenre: e['genres'][0]['name'],
      );
    }).toList();
    return transformed;
  }

  static Future<List<Detail>> fetchDetailGames() async {
    const url =
        'https://api.rawg.io/api/games/3498?key=3be8af6ebf124ffe81d90f514e59856c';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      return Detail(
        description: e["description"],
      );
    }).toList();
    return transformed;
  }
}
