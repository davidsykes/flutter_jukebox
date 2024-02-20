import 'package:flutter/material.dart';

class JbElevatedButton extends StatelessWidget {
  final String text;
  final Color colour;
  final void Function() onPressed;
  final double height;

  const JbElevatedButton(this.text, this.colour, this.onPressed,
      {required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colour,
        minimumSize: Size(0, height),
      ),
      child: Text(text),
    );
  }
}
