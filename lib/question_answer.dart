import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({super.key});

  @override
  State<QuestionAnswer> createState() {
    return _QuestionAnswer();
  }
}

class _QuestionAnswer extends State<QuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return const Text('Question Answer');
  }
}
