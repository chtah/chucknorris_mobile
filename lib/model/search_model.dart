import 'package:chucknorris/model/joke_model.dart';

class SearchModel {
  int total;
  List<JokeModel> result;

  SearchModel({
    required this.total,
    required this.result,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      total: json['total'],
      result: (json['result'] as List)
          .map((resultJson) => JokeModel.fromJson(resultJson))
          .toList(),
    );
  }
}
