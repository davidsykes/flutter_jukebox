import 'package:flutter/material.dart';
import '../potentiallibrary/programexception.dart';
import '../potentiallibrary/utilities/actionhandler.dart';

class TextButtonAsyncActionWidget extends StatefulWidget {
  final String _buttonText;
  final ActionHandler _action;
  const TextButtonAsyncActionWidget(this._buttonText, this._action,
      {super.key});

  @override
  State<TextButtonAsyncActionWidget> createState() =>
      _TextButtonAsyncActionState();
}

class _TextButtonAsyncActionState extends State<TextButtonAsyncActionWidget> {
  MaterialColor _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_color),
      ),
      onPressed: isButtonEnabled()
          ? () async {
              setState(() {
                _color = Colors.yellow;
              });
              try {
                var result = await widget._action.action();
                setState(() {
                  if (result) {
                    _color = Colors.green;
                  } else {
                    _color = Colors.red;
                  }
                });
              } on ProgramException {
                setState(() {
                  _color = Colors.red;
                });
              }
            }
          : null,
      child: Text(widget._buttonText),
    );
  }

  bool isButtonEnabled() {
    return true;
  }
}
