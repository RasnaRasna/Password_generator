import 'package:flutter/material.dart';
import 'package:password_generator/const/const.dart';

Widget buildCheckboxRow(
    String texts, String text, bool isChecked, Function(bool?) onChanged) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black26),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            texts,
            style: const TextStyle(
                fontSize: 18, color: GreenColor, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 18, color: GreenColor, fontWeight: FontWeight.bold),
            ),
          ),
          Checkbox(
            side: const BorderSide(color: GreenColor),
            checkColor: Colors.white,
            activeColor: GreenColor,
            value: isChecked,
            onChanged: onChanged,
          ),
        ],
      ),
    ),
  );
}
