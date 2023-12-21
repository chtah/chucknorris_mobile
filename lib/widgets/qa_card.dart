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
      color: isExpanded ? const Color.fromARGB(255, 241, 90, 34) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.question,
                style: TextStyle(
                    color: isExpanded
                        ? Colors.white
                        : const Color.fromARGB(255, 56, 64, 78),
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: isExpanded
                    ? Colors.white
                    : const Color.fromARGB(255, 56, 64, 78),
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
              Container(
                color: const Color.fromARGB(255, 241, 90, 34),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('A : ',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Expanded(
                        child: Text(
                          widget.answer,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
