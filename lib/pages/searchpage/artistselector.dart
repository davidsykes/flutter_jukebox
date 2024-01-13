// DropdownMenuEntry labels and values for the first dropdown menu.
import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownMenu<int>(
            initialSelection: 2,
            requestFocusOnTap: true,
            label: const Text('Artist'),
            onSelected: (int? artistId) {
              setState(() {
                selectedColor = artistId.toString();
              });
            },
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 1, label: 'label 1'),
              DropdownMenuEntry(value: 2, label: 'label 2'),
              DropdownMenuEntry(value: 3, label: 'label 3'),
            ],
          ),
        ],
      ),
    );
  }
}
