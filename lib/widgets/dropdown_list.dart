import 'package:flutter/material.dart';

class DropdownList extends StatelessWidget {
  const DropdownList({
    super.key,
    required this.itemList,
    required this.controller,
    required this.onChange,
    required this.label,
  });

  final List<String> itemList;
  final String controller;
  final void Function(dynamic) onChange;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          InputDecorator(
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder()),
            child: Column(
              children: [
                Text(label,
                    style: const TextStyle(
                        fontFamily: 'Courier New',
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      items: itemList.map(
                        (value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(
                                    fontFamily: 'Courier New',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          );
                        },
                      ).toList(),
                      hint: Text(
                        controller == 'random' ? 'random' : controller,
                        style: const TextStyle(
                            fontFamily: 'Courier New',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onChanged: onChange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
