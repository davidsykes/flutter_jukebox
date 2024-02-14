import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/widgets/futurebuilder.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import '../dataobjects/recentlyplayedtracksdata.dart';

class RecentlyPlayedTracksWidget extends StatefulWidget {
  final IMicroServiceController _microServiceController;

  const RecentlyPlayedTracksWidget(this._microServiceController, {super.key});

  @override
  State<RecentlyPlayedTracksWidget> createState() =>
      _RecentlyPlayedTracksWidgetState();
}

class _RecentlyPlayedTracksWidgetState
    extends State<RecentlyPlayedTracksWidget> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<RecentlyPlayedTracksData>(
        dataFetcher: dataFetcher(), pageMaker: pageMaker);
  }

  Future<RecentlyPlayedTracksData> dataFetcher() {
    return widget._microServiceController.getRecentlyPlayedTracks();
  }

  Widget pageMaker(RecentlyPlayedTracksData recentlyPlayedTracksData) {
    return Text(recentlyPlayedTracksData.placeHolder);
  }
}
