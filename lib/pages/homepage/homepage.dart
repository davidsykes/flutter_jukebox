import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'package:flutter_jukebox/dataobjects/recentlyplayedtrackdata.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import 'package:flutter_jukebox/widgets/recentlyplayedtrackswidget.dart';
import '../../dataobjects/cachedcurrentlyplayingtrackinformation.dart';
import '../../webaccess/jukeboxdatabaseapiaccess.dart';
import '../../webaccess/mp3playeraccess.dart';
import 'currentlyplaying.dart';
import 'jukeboxcollectionselectorwidget.dart';

class HomePage extends StatefulWidget {
  final IMP3PlayerAccess mp3PlayerAccess;
  final IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
  final IMicroServiceController microServiceController;
  const HomePage(this.mp3PlayerAccess, this.jukeboxDatabaseApiAccess,
      this.microServiceController,
      {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CachedValue<List<JukeboxCollection>> _jukeboxCollections;
  late CurrentlyPlayingTrackInformationFetcher
      _currentlyPlayingTrackInformationFetcher;
  late CachedValue<List<RecentlyPlayedTrackData>> _recentlyPlayedTracks;

  @override
  void initState() {
    super.initState();

    _jukeboxCollections = CachedValue<List<JukeboxCollection>>(
        widget.microServiceController.getJukeboxCollections);

    _currentlyPlayingTrackInformationFetcher =
        CurrentlyPlayingTrackInformationFetcher(
            widget.microServiceController.getCurrentTrackInformation);

    _recentlyPlayedTracks = CachedValue<List<RecentlyPlayedTrackData>>(
        widget.microServiceController.getRecentlyPlayedTracks);
  }

  @override
  Widget build(BuildContext context) {
    return makeHomePage();
  }

  Widget makeHomePage() {
    var rows = List<Widget>.empty(growable: true);
    rows.add(const Text(''));
    rows.add(JukeboxCollectionSelectorWidget(
        widget.microServiceController, _jukeboxCollections));
    rows.add(const Text(''));
    rows.add(CurrentlyPlayingWidget(
        _currentlyPlayingTrackInformationFetcher, refresh));
    rows.add(const Text(''));
    rows.add(RecentlyPlayedTracksWidget(_recentlyPlayedTracks));

    return Column(
      children: rows,
    );
  }

  void refresh() {
    setState(() {});
  }
}
