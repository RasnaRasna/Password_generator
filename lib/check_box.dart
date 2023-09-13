import 'package:flutter/material.dart';

Widget buildCheckboxRow(
    String text, bool isChecked, Function(bool?) onChanged) {
  return Card(
    color: Color.fromARGB(255, 75, 42, 30),
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
          Text(
            text,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Checkbox(
            side: BorderSide(color: Colors.white),
            checkColor: Colors.black,
            activeColor: Colors.white,
            value: isChecked,
            onChanged: onChanged,
          ),
        ],
      ),
    ),
  );
}
