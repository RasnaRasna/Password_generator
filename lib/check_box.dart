import 'package:flutter/material.dart';

Widget buildCheckboxRow(
    String text, bool isChecked, Function(bool?) onChanged) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 4,
    margin: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("fzxcgvb"),
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
        ],
      ),
    ),
  );
}
