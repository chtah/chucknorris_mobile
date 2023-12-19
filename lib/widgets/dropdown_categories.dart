import 'package:flutter/material.dart';

class DropdownCategories extends StatelessWidget {
  const DropdownCategories({
    super.key,
    required this.itemList,
    required this.controller,
    required this.onChange,
  });

  final List<String> itemList;
  final String controller;
  final void Function(dynamic) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          InputDecorator(
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                items: itemList.map(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                hint: Text(controller == 'random' ? 'random' : controller),
                onChanged: onChange,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
