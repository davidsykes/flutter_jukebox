import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/currenttrack.dart';
import 'dataobjects/trackinformation.dart';
import 'potentiallibrary/widgets/futurebuilder.dart';
import 'tools/logger.dart';
import 'webaccess/jukeboxdatabaseapiaccess.dart';
import 'webaccess/mp3playeraccess.dart';

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
    try {
      var currentTrackId = await widget.mp3PlayerAccess.getCurrentTrackId();
      if (currentTrackId > 0) {
        return widget.jukeboxDatabaseApiAccess
            .getTrackInformation(currentTrackId);
      }
    } on Exception catch (e) {
      Logger().log('an exception $e');
    }
    return TrackInformation(
      0,
      'No track playing',
      'rt',
      2,
      'tr',
      'gg',
      1,
      'g',
    );
  }

  CurrentTrack deserialiseCurrentTrack(Map<String, dynamic> data) {
    return CurrentTrack(data['currentTrackId']);
  }

  Widget makeHomePage(TrackInformation currentTrackInformation) {
    var texts = List.empty(growable: true);
    texts.add(currentTrackInformation.trackName);
    texts.addAll(Logger.logs);
    var textiesi = texts.map(
      (e) => Text(e),
    );
    return Column(
      children: textiesi.toList(),
    );
  }
}
