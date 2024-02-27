import 'package:flutter/material.dart';

class TrackListOption {
  int value;
  String label;
  TrackListOption(this.value, this.label);
}

class TrackListSelectorWidget extends StatelessWidget {
  final void Function(int trackType) updateSearchScreenInformation;

  const TrackListSelectorWidget(this.updateSearchScreenInformation,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      TrackListOption(0, 'All Tracks'),
      TrackListOption(1, 'Deleted Tracks'),
    ];

    var dropMenus =
        items.map((v) => DropdownMenuEntry(value: v.value, label: v.label));

    final sample = ['a', 'b', 'c'];
    for (final (index, item) in sample.indexed) {
      f(index, item);
    }

    return DropdownMenu<int>(
      initialSelection: 0,
      requestFocusOnTap: true,
      label: const Text('Tracks'),
      onSelected: (int? selection) {
        print('selected $selection');
        updateSearchScreenInformation(selection!);
      },
      dropdownMenuEntries: dropMenus.toList(),
    );
  }

  void f(int index, String item) {}
}
