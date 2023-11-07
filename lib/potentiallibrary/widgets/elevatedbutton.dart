import 'package:flutter/material.dart';

Widget createElevatedButton(String text, void Function() onPressed) {
  return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(text));
}
