import 'package:chucknorris/list.dart';
import 'package:chucknorris/question_answer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  int selectedPage = 0;
  final pageOption = [const List(), const QuestionAnswer()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'chucknorris',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 241, 90, 36),
        ),
        body: pageOption[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 241, 90, 36),
          currentIndex: selectedPage,
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Joke'),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer_rounded), label: 'Q&A')
          ],
        ),
      ),
    );
  }
}
