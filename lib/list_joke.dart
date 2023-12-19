import 'package:chucknorris/widgets/dropdown_categories.dart';
import 'package:flutter/material.dart';
import 'package:chucknorris/provider/joke_get.dart';
import 'package:chucknorris/model/joke_model.dart';

class ListJoke extends StatefulWidget {
  const ListJoke({super.key});

  @override
  State<ListJoke> createState() {
    return _List();
  }
}

class _List extends State<ListJoke> {
  late Future<List<JokeModel>> randomJokes;
  late Future<List<String>> allCategories;
  String categoryController = '';
  int totalJoke = 1;

  @override
  void initState() {
    super.initState();
    updateRandomJokes();

    allCategories = JokeGet().getCategories();
  }

  void updateRandomJokes() {
    List<Future<JokeModel>> jokeList = [];
    for (int i = 0; i < totalJoke; i++) {
      if (categoryController.isNotEmpty) {
        jokeList.add(JokeGet().getJokeByCategory(categoryController));
      } else {
        jokeList.add(JokeGet().getJoke());
      }
    }

    setState(() {
      randomJokes = Future.wait(jokeList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([randomJokes, allCategories]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final randomJoke = snapshot.data![0] as List<JokeModel>;
          final categories = snapshot.data![1] as List<String>;
          return Column(
            children: [
              DropdownCategories(
                  itemList: categories,
                  controller: categoryController,
                  onChange: (value) {
                    if (value != null) {
                      setState(
                        () {
                          categoryController = value;
                          updateRandomJokes();
                        },
                      );
                    }
                  },
                  hint: 'Category'),
              DropdownCategories(
                  itemList: const ['1', '5', '10'],
                  controller: totalJoke.toString(),
                  onChange: (value) {
                    if (value != null) {
                      setState(
                        () {
                          totalJoke = int.parse(value);
                          updateRandomJokes();
                        },
                      );
                    }
                  },
                  hint: 'Category'),
              Expanded(
                child: ListView.builder(
                  itemCount: randomJoke.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(randomJoke[index].value),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
