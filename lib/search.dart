import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() {
    return _Search();
  }
}

class _Search extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return const Text('Search');
  }
}