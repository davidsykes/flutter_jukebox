import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../actions/playsinglemp3action.dart';
import '../../actions/undeletetrack.dart';
import '../../webaccess/microservicecontroller.dart';
import '../../widgets/textbuttonasyncactionwidget.dart';
import 'searchpagetracklisttype.dart';

class TrackListTrackEntryWidget extends StatelessWidget {
  final TrackInformation track;
  final SearchPageTrackListTypeOption trackTypeOption;
  final void Function(TrackInformation track) setItemToEdit;
  final IMicroServiceController _serviceController;

  const TrackListTrackEntryWidget(this.track, this.trackTypeOption,
      this.setItemToEdit, this._serviceController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var childList = <Widget>[
      TextButtonAsyncActionWidget(
          'Play',
          PlaySingleMP3Action(
              _serviceController, track.getJukeboxTrackPathAndFileName())),
    ];

    if (trackTypeOption == SearchPageTrackListTypeOption.deletedTracks) {
      childList.add(
        TextButtonAsyncActionWidget(
            'Undelete', UndeleteTrack(_serviceController, track.trackId)),
      );
    }
    childList.add(trackToText(track));

    return Row(
      children: childList,
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
        child: Text('$t - $artist - $album'),
        onTap: () {
          setItemToEdit(track);
        });
  }
}
