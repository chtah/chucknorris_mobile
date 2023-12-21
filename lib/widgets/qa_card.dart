import 'package:flutter/material.dart';

class QACard extends StatefulWidget {
  const QACard({
    super.key,
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;

  @override
  State<QACard> createState() {
    return _QACard();
  }
}

class _QACard extends State<QACard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.question,
              style: const TextStyle(color: Colors.blue),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.blue,
            ),
            onTap: () {
              setState(
                () {
                  isExpanded = !isExpanded;
                },
              );
            },
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('A : ',
                      style:
                          TextStyle(color: Color.fromARGB(255, 233, 33, 19))),
                  Expanded(
                    child: Text(
                      widget.answer,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 233, 33, 19)),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
