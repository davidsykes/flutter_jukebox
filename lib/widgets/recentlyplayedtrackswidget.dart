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
    return Text('recentlyPlayedTracksData.placeHolder');
  }
}
