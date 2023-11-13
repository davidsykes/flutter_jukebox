import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/currenttrack.dart';
import 'dataobjects/trackinformation.dart';
import 'potentiallibrary/webaccess/mp3playeraccess.dart';
import 'potentiallibrary/widgets/futurebuilder.dart';
import 'potentiallibrary/webaccess/jukeboxdatabaseapiaccess.dart';

class HomePage extends StatefulWidget {
  final IMP3PlayerAccess mp3PlayerAccess;
  final IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
  const HomePage(this.mp3PlayerAccess, this.jukeboxDatabaseApiAccess,
      {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<TrackInformation>(
        getCurrentTrackInformation, makeHomePage);
  }

  Future<TrackInformation> getCurrentTrackInformation() async {
    var currentTrackId = await widget.mp3PlayerAccess.getCurrentTrackId();
    return widget.jukeboxDatabaseApiAccess.getTrackInformation(currentTrackId);
  }

  CurrentTrack deserialiseCurrentTrack(Map<String, dynamic> data) {
    return CurrentTrack(data['currentTrackId']);
  }

  Widget makeHomePage(TrackInformation currentTrackInformation) {
    return Text(currentTrackInformation.trackName);
  }
}
