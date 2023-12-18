import 'package:chucknorris/widgets/dropdown_categories.dart';
import 'package:flutter/material.dart';
import 'package:chucknorris/provider/joke_get.dart';
import 'package:chucknorris/model/joke_model.dart';

class List extends StatefulWidget {
  const List({super.key});

  @override
  State<List> createState() {
    return _List();
  }
}

class _List extends State<List> {
  late Future<Joke> randomJoke;
  late Future<dynamic> allCategories;
  String _categoryController = '';

  @override
  void initState() {
    super.initState();

    randomJoke = JokeGet().getJoke();
    allCategories = JokeGet().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([randomJoke, allCategories]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final randomJoke = snapshot.data![0];
          final categories = snapshot.data![1];
          return Column(
            children: [
              DropdownCategories(
                  itemList: categories,
                  controller: _categoryController,
                  onChange: (value) {
                    if (value != null) {
                      setState(
                        () {
                          _categoryController = value;
                        },
                      );
                    }
                  },
                  hint: 'Category'),
              Text('${randomJoke.value}'),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
