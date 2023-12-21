import 'package:chucknorris/model/search_model.dart';
import 'package:chucknorris/widgets/animation_logo.dart';
import 'package:chucknorris/widgets/dropdown_list.dart';
import 'package:chucknorris/widgets/webview.dart';
import 'package:flutter/material.dart';
import 'package:chucknorris/provider/joke_get.dart';
import 'package:chucknorris/model/joke_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListJoke extends StatefulWidget {
  const ListJoke({super.key});

  @override
  State<ListJoke> createState() {
    return _ListJoke();
  }
}

class _ListJoke extends State<ListJoke> with WidgetsBindingObserver {
  late Future<List<JokeModel>> randomJokes = Future.value([]);
  late Future<List<String>> allCategories = Future.value([]);
  late TextEditingController searchController = TextEditingController();
  late Future<SearchModel> jokesBySearch;
  late List<String> categories = [];
  String categoryController = 'random';
  int totalJoke = 1;
  List<JokeModel> fetchedJokes = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _loadSavedState();

    JokeGet().getCategories().then((categoryList) {
      setState(() {
        categories = [...categoryList];
        allCategories = Future.value(categories);
      });
      updateRandomJokes();
    });

    searchController = TextEditingController();
    jokesBySearch = Future.value(SearchModel(total: 0, result: []));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _saveState();
    }
  }

  void _loadSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      categoryController = prefs.getString('category') ?? 'random';
      totalJoke = prefs.getInt('totalJoke') ?? 1;
      searchController.text = prefs.getString('searchText') ?? '';

      if (searchController.text.isNotEmpty) {
        searchJokes();
      }
    });
  }

  void _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('category', categoryController);
    await prefs.setInt('totalJoke', totalJoke);
    await prefs.setString('searchText', searchController.text);
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
        setState(
          () {
            jokesBySearch = Future.value(
              SearchModel(total: searchResult.length, result: searchResult),
            );
            _saveState();
          },
        );
      } catch (error) {
        errorMessage = 'Error Message: $error';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const RotateImage(),
          if (searchController.text.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownList(
                  itemList: categories,
                  controller: categoryController,
                  label: 'Category',
                  onChange: (value) {
                    if (value != 'random') {
                      setState(
                        () {
                          categoryController = value;
                          updateRandomJokes();
                          _saveState();
                        },
                      );
                    } else {
                      setState(
                        () {
                          categoryController = value;
                          updateRandomJokes();
                          _saveState();
                        },
                      );
                    }
                  },
                ),
                const SizedBox(width: 50),
                if (searchController.text.isEmpty)
                  DropdownList(
                    itemList: const ['1', '5', '10'],
                    controller: totalJoke.toString(),
                    label: 'Total',
                    onChange: (value) {
                      if (value != null) {
                        setState(
                          () {
                            totalJoke = int.parse(value);
                            updateRandomJokes();
                            _saveState();
                          },
                        );
                      }
                    },
                  ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter search text',
                      hintStyle: const TextStyle(
                          fontFamily: 'Courier New',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            FocusScope.of(context).unfocus();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    searchJokes;
                    FocusScope.of(context).unfocus();
                    _saveState();
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(
                        fontFamily: 'Courier New',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Future.wait([
                searchController.text.isNotEmpty ? jokesBySearch : randomJokes,
                allCategories
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: errorMessage.isNotEmpty
                          ? Text(errorMessage)
                          : const CircularProgressIndicator());
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
                  final dataCategory = snapshot.data![1] as List<String>;
                  categories = ['random', ...dataCategory];
                  return ListView.builder(
                    itemCount: randomJoke.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewScreen(
                                url: randomJoke[index].url,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      randomJoke[index].value,
                                      style: const TextStyle(
                                          fontFamily: 'Courier New',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 6,
                                right: 6,
                                // child: Image.network(
                                //   randomJoke[index].icon_url,
                                //   width: 20,
                                //   height: 20,
                                // ), // !!cant use because image link dead
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                      'assets/images/chuck_norris_avatar.png',
                                      width: 20,
                                      height: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
