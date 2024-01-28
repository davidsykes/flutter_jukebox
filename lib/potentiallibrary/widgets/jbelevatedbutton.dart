import 'package:flutter/material.dart';

class JbElevatedButton extends StatelessWidget {
  final String text;
  final Color colour;
  final void Function() onPressed;

  const JbElevatedButton(this.text, this.colour, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colour,
      ),
      child: Text(text),
    );
  }
}
