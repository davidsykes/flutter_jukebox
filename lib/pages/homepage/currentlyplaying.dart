import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';

class CurrentlyPlayingWidget extends StatelessWidget {
  final TrackInformation? trackInformation;

  const CurrentlyPlayingWidget(this.trackInformation, {super.key});

  @override
  Widget build(BuildContext context) {
    if (trackInformation == null) {
      return const Text('No music is playing right now');
    }

    var currentTrack = trackInformation!;

    return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Currently Playing',
              style: TextStyle(fontSize: 18, fontFamily: 'Comic Sans MS'),
            ),
            Text(
              'Track: ${currentTrack.trackName}',
              style: const TextStyle(fontSize: 24, fontFamily: 'Comic Sans MS'),
            ),
            Text(
              'Album: ${currentTrack.albumName}',
              style: const TextStyle(fontSize: 24, fontFamily: 'Comic Sans MS'),
            ),
            Text(
              'Artist: ${currentTrack.artistName}',
              style: const TextStyle(fontSize: 24, fontFamily: 'Comic Sans MS'),
            ),
          ],
        ));
  }
}
