import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/actionhandler.dart';
import 'jbelevatedbutton.dart';

class ElevatedButtonActionWidget extends StatefulWidget {
  final String _label;
  final ActionHandler _action;

  const ElevatedButtonActionWidget(this._label, this._action, {super.key});

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
      0 => Colors.amber,
      1 => Colors.green,
      _ => Colors.red
    };

    return JbElevatedButton(widget._label, colour, () async {
      setState(() {
        state = 1;
      });
      try {
        var result = await widget._action.action();
        setState(() {
          state = result ? 0 : 2;
        });
      } catch (e) {
        setState(() {
          state = 2;
        });
        rethrow;
      }
    });
  }
}
