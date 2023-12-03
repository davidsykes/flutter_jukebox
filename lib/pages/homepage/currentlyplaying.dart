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

    return const Text('Currently Playing');
  }
}
