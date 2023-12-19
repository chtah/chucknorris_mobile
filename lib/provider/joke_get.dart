import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chucknorris/model/joke_model.dart';

class JokeGet {
  Future<JokeModel> getJoke() async {
    final res =
        await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

    if (res.statusCode == 200) {
      final decodedRes = jsonDecode(res.body);
      return JokeModel.fromJson(decodedRes);
    } else {
      throw Exception('Fetch Error');
    }
  }

  Future<JokeModel> getJokeByCategory() async {
    final res = await http.get(Uri.parse(
        'https://api.chucknorris.io/jokes/random?category={category}'));

    if (res.statusCode == 200) {
      final decodedRes = jsonDecode(res.body);
      return JokeModel.fromJson(decodedRes);
    } else {
      throw Exception('Fetch Error');
    }
  }

  Future<List<String>> getCategories() async {
    final res = await http
        .get(Uri.parse('https://api.chucknorris.io/jokes/categories'));

    if (res.statusCode == 200) {
      final List<dynamic> decodedRes = jsonDecode(res.body);
      return List<String>.from(decodedRes);
    } else {
      throw Exception('Fetch Error');
    }
  }
}
