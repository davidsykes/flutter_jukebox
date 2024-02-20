import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import 'package:flutter_jukebox/potentiallibrary/widgets/futurebuilder.dart';
import '../dataobjects/recentlyplayedtrackdata.dart';

class RecentlyPlayedTracksWidget extends StatefulWidget {
  final CachedValue<List<RecentlyPlayedTrackData>> _recentlyPlayedTracksData;

  const RecentlyPlayedTracksWidget(this._recentlyPlayedTracksData, {super.key});

  @override
  State<RecentlyPlayedTracksWidget> createState() =>
      _RecentlyPlayedTracksWidgetState();
}

class _RecentlyPlayedTracksWidgetState
    extends State<RecentlyPlayedTracksWidget> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<List<RecentlyPlayedTrackData>>(
        dataFetcher: widget._recentlyPlayedTracksData.getData(),
        pageMaker: pageMaker);
  }

  Widget pageMaker(List<RecentlyPlayedTrackData> recentlyPlayedTracks) {
    return Column(
        children: <Widget>[
              const Row(children: [
                Text('Recently played tracks:'),
              ])
            ] +
            [
              makeTableForEntries(recentlyPlayedTracks),
            ]);
  }

  Widget makeTableForEntries(List<RecentlyPlayedTrackData> rpt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        makeColumn(rpt.map((e) => e.track.trackName)),
        makeColumn(rpt.map((e) => e.track.artistName)),
        makeColumn(rpt.map((e) => e.track.albumName)),
      ],
    );
  }

  Widget makeColumn(Iterable<String> map) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: map
          .map((e) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0, color: const Color.fromARGB(255, 214, 205, 76)),
              ),
              child: Text(e)))
          .toList(),
    );
  }

  // List<Widget> makePlayedTrackEntries(
  //     List<RecentlyPlayedTrackData> recentlyPlayedTracks) {
  //   return recentlyPlayedTracks.map((e) => makePlayedTrackEntry(e)).toList();
  // }

  // Widget makePlayedTrackEntry(RecentlyPlayedTrackData e) {
  //   return Container(
  //       decoration: BoxDecoration(
  //         border:
  //             Border.all(width: 2.0, color: Color.fromARGB(255, 214, 205, 76)),
  //       ),
  //       child: Row(
  //         children: [
  //           Text(e.track.trackName),
  //           Text(e.track.artistName),
  //           Text(e.track.albumName),
  //         ],
  //       ));
  // }
}
