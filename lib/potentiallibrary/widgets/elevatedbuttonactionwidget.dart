import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/actionhandler.dart';
import 'jbelevatedbutton.dart';

class ElevatedButtonActionWidget extends StatefulWidget {
  final ActionHandler _action;

  const ElevatedButtonActionWidget(this._action, {super.key});

  @override
  State<ElevatedButtonActionWidget> createState() =>
      _ElevatedButtonActionWidgetState();
}

class _ElevatedButtonActionWidgetState
    extends State<ElevatedButtonActionWidget> {
  int state = 0;

  @override
  Widget build(Object context) {
    var colour = switch (state) {
      0 => Colors.green,
      1 => Colors.amber,
      _ => Colors.red
    };

    return JbElevatedButton('Play', colour, () async {
      setState(() {
        state = 1;
      });
      var result = await widget._action.action(0);
      setState(() {
        state = result ? 0 : 2;
      });
    });
  }
}
