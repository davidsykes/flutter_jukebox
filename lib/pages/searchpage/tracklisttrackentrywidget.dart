import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../widgets/textbuttonasyncactionwidget.dart';

class TrackListTrackEntryWidget extends StatelessWidget {
  final TrackInformation track;
  final void Function(TrackInformation track) setItemToEdit;

  const TrackListTrackEntryWidget(this.track, this.setItemToEdit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButtonAsyncActionWidget('Play', playTrack),
        trackToText(track),
      ],
    );
  }

  Future<bool> playTrack() {
    return Future(() => false);
  }

  Widget trackToText(TrackInformation track) {
    var t = track.trackName;
    var artist = track.artistName;
    var album = track.albumName;
    return GestureDetector(
        child: Text('? $t - $artist - $album'),
        onTap: () {
          setItemToEdit(track);
        });
  }
}
