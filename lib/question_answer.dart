import 'package:chucknorris/widgets/qa_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({
    super.key,
  });

  @override
  State<QuestionAnswer> createState() {
    return _QuestionAnswer();
  }
}

class _QuestionAnswer extends State<QuestionAnswer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        QACard(question: 'question', answer: 'answer'),
        QACard(question: 'question', answer: 'answer'),
        QACard(question: 'question', answer: 'answer'),
        QACard(question: 'question', answer: 'answer'),
        QACard(question: 'question', answer: 'answer')
      ],
    );
  }
}
