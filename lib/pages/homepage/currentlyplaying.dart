import 'package:flutter/material.dart';
import '../../dataobjects/cachedcurrentlyplayingtrackinformation.dart';
import '../../potentiallibrary/utilities/actionhandler.dart';
import '../../potentiallibrary/widgets/elevatedbuttonactionwidget.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';

class CurrentlyPlayingWidget extends StatelessWidget {
  final CurrentlyPlayingTrackInformationFetcher currentTrackInformationFetcher;
  final void Function() _refreshParent;

  const CurrentlyPlayingWidget(
      this.currentTrackInformationFetcher, this._refreshParent,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<CurrentlyPlayingTrackInformation>(
        dataFetcher: currentTrackInformationFetcher.getData(),
        pageMaker: makePage);
  }

  Widget makePage(CurrentlyPlayingTrackInformation trackInformation) {
    if (trackInformation.info == null) {
      return const Text('No music is playing right now');
    }

    var currentTrack = trackInformation.info!;

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
            ElevatedButtonActionWidget(
                'Refresh', ActionReturningVoid(() => refresh())),
          ],
        ));
  }

  bool refresh() {
    currentTrackInformationFetcher.reset();
    _refreshParent();
    return true;
  }
}
