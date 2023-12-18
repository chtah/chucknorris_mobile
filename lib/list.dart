import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class List extends StatefulWidget {
  const List({super.key});

  @override
  State<List> createState() {
    return _List();
  }
}

class _List extends State<List> {
  @override
  Widget build(BuildContext context) {
    return const Text('List');
  }
}