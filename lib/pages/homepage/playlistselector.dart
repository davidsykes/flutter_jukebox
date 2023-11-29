import 'package:flutter/material.dart';

class PlayLstSelectorgWidget extends StatelessWidget {
  const PlayLstSelectorgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Play Lists')),
        const Text('Play Lists'),
        const Text('Play Lists'),
      ],
    );
  }
}
