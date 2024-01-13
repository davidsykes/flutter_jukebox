import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../dataobjects/artistinformation.dart';
import 'artistselector.dart';

Widget makeTrackEditor(
    TrackInformation track, List<ArtistInformation> artists) {
  var rows = List<Widget>.empty(growable: true);

  rows.add(Text(track.trackName));

  rows.add(makeArtistRow(track, artists));
  rows.add(const Text('Reset'));

  return Column(
    children: rows,
  );
}

Widget makeArtistRow(TrackInformation track, List<ArtistInformation> artists) {
  return Row(children: [
    const SizedBox(
      width: 100,
      child: Text('Artist'),
    ),
    SizedBox(
      width: 100,
      child: Text(track.artistName),
    ),
    SizedBox(
      width: 200,
      child: DropdownMenuExample(artists),
    ),
  ]);
}
