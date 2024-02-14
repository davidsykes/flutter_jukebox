import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import 'package:flutter_jukebox/potentiallibrary/widgets/futurebuilder.dart';
import '../dataobjects/recentlyplayedtracksdata.dart';

class RecentlyPlayedTracksWidget extends StatefulWidget {
  final CachedValue<RecentlyPlayedTracksData> _recentlyPlayedTracksData;

  const RecentlyPlayedTracksWidget(this._recentlyPlayedTracksData, {super.key});

  @override
  State<RecentlyPlayedTracksWidget> createState() =>
      _RecentlyPlayedTracksWidgetState();
}

class _RecentlyPlayedTracksWidgetState
    extends State<RecentlyPlayedTracksWidget> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<RecentlyPlayedTracksData>(
        dataFetcher: widget._recentlyPlayedTracksData.getData(),
        pageMaker: pageMaker);
  }

  Widget pageMaker(RecentlyPlayedTracksData recentlyPlayedTracksData) {
    return Text(recentlyPlayedTracksData.placeHolder);
  }
}
