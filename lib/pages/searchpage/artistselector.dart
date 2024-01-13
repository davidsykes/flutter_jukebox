// DropdownMenuEntry labels and values for the first dropdown menu.
import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/artistinformation.dart';

class DropdownMenuExample extends StatefulWidget {
  final List<ArtistInformation> artists;
  const DropdownMenuExample(this.artists, {super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    var dropMenus = widget.artists
        .map((e) => DropdownMenuEntry(value: e.id, label: e.name));

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
            dropdownMenuEntries: dropMenus.toList(),
          ),
        ],
      ),
    );
  }
}
