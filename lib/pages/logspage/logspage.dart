import 'package:flutter/material.dart';
import '../../tools/logger.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var texts = List.empty(growable: true);
    texts.addAll(Logger.logs);
    var textiesi = texts.map(
      (e) => Text(e),
    );

    var rows = List<Widget>.empty(growable: true);
    rows.addAll(textiesi);

    return Column(
      children: rows,
    );
  }
}
