import 'dart:convert';
import 'package:myapp/model/game.dart';
import 'package:http/http.dart' as http;

Future<List<Game>> fetchGames() async {
  final response = await http.get(Uri.parse('https://www.freetogame.com/api/games')); // [cite: 358]

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body); // [cite: 359]
    return jsonData.map((item) => Game.fromJson(item)).toList(); // [cite: 360]
  } else {
    throw Exception('Gagal mengambil data game'); // [cite: 358]
  }
}

Future<Map<String, dynamic>> fetchDataFromAPI(int idGame) async {
  final response = await http.get(Uri.parse('https://www.freetogame.com/api/game?id=$idGame')); // [cite: 465]

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body); // [cite: 468]
    if (jsonData != null && jsonData is Map<String, dynamic>) {
      return jsonData; // [cite: 465]
    } else {
      throw Exception('Data dari API tidak sesuai dengan yang diharapkan'); // [cite: 465]
    }
  } else {
    throw Exception('Gagal mengambil data dari API'); // [cite: 465]
  }
}