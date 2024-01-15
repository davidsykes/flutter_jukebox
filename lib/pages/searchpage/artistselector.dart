// DropdownMenuEntry labels and values for the first dropdown menu.
import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/artistinformation.dart';
import '../../potentiallibrary/utilities/actionhandler.dart';

class ArtistSelector extends StatefulWidget {
  final List<ArtistInformation> artists;
  final ActionHandler artistSelectionHandler;
  const ArtistSelector(this.artists, this.artistSelectionHandler, {super.key});

  @override
  State<ArtistSelector> createState() => _ArtistSelectorState();
}

class _ArtistSelectorState extends State<ArtistSelector> {
  int? selectedArtist;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var dropMenus = widget.artists
        .where((e) => e.name.toLowerCase().contains(searchText))
        .take(100)
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
                selectedArtist = artistId;
              });
            },
            dropdownMenuEntries: dropMenus.toList(),
          ),
          Text('($selectedArtist)'),
          const Text('Filter'),
          SizedBox(
            width: 100,
            child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
                onChanged: (text) {
                  setState(() {
                    searchText = text;
                  });
                }),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              widget.artistSelectionHandler.action(selectedArtist!);
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
