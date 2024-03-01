import 'package:flutter/material.dart';
import '../searchpage/searchpagetracklisttype.dart';

class TrackListOption {
  SearchPageTrackListTypeOption value;
  String label;
  TrackListOption(this.value, this.label);
}

class TrackListSelectorWidget extends StatelessWidget {
  final void Function(SearchPageTrackListTypeOption trackType)
      updateSearchScreenInformation;

  const TrackListSelectorWidget(this.updateSearchScreenInformation,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      TrackListOption(SearchPageTrackListTypeOption.allTracks, 'All Tracks'),
      TrackListOption(
          SearchPageTrackListTypeOption.deletedTracks, 'Deleted Tracks'),
    ];

    var dropMenus =
        items.map((v) => DropdownMenuEntry(value: v.value, label: v.label));

    return DropdownMenu<SearchPageTrackListTypeOption>(
      initialSelection: SearchPageTrackListTypeOption.allTracks,
      requestFocusOnTap: true,
      label: const Text('Tracks'),
      onSelected: (SearchPageTrackListTypeOption? selection) {
        updateSearchScreenInformation(selection!);
      },
      dropdownMenuEntries: dropMenus.toList(),
    );
  }
}
