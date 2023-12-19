import 'package:chucknorris/model/search_model.dart';
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
  late TextEditingController searchController = TextEditingController();
  late Future<SearchModel> jokesBySearch;
  String categoryController = 'random';
  int totalJoke = 1;

  @override
  void initState() {
    super.initState();
    updateRandomJokes();

    allCategories = JokeGet().getCategories();
    searchController = TextEditingController();
  }

  void updateRandomJokes() {
    List<Future<JokeModel>> jokeList = [];
    for (int i = 0; i < totalJoke; i++) {
      if (categoryController != 'random') {
        jokeList.add(JokeGet().getJokeByCategory(categoryController));
      } else {
        jokeList.add(JokeGet().getJoke());
      }
    }

    setState(() {
      randomJokes = Future.wait(jokeList);
    });
  }

  void searchJokes() async {
    final searchText = searchController.text;
    if (searchText.isNotEmpty) {
      try {
        final searchResult = await JokeGet().getJokeByText(searchText);
        setState(() {
          jokesBySearch = Future.value(
              SearchModel(total: searchResult.length, result: searchResult));
          print('Test: $jokesBySearch');
        });
      } catch (error) {
        print('Error fetching search results: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        searchController.text.isNotEmpty ? jokesBySearch : randomJokes,
        allCategories
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          late List<JokeModel> randomJoke;
          if (searchController.text.isNotEmpty) {
            final searched = snapshot.data![0] as SearchModel;
            randomJoke = searched.result;
          } else {
            randomJoke = snapshot.data![0] as List<JokeModel>;
          }
          final categories = snapshot.data![1] as List<String>;
          final addRandomCategory = ['random', ...categories];
          return Column(
            children: [
              DropdownCategories(
                itemList: addRandomCategory,
                controller: categoryController,
                onChange: (value) {
                  if (value != 'random') {
                    setState(
                      () {
                        categoryController = value;
                        updateRandomJokes();
                      },
                    );
                  } else {
                    setState(
                      () {
                        categoryController = value;
                        updateRandomJokes();
                      },
                    );
                  }
                },
              ),
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Enter search text',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: searchJokes,
                      child: const Text('Search'),
                    ),
                  ],
                ),
              ),
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
