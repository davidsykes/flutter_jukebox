import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/currenttrack.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';
import 'currenttrackinformation.dart';
import 'potentiallibrary/webaccess/webrequestor.dart';
import 'potentiallibrary/widgets/futurebuilder.dart';

class HomePage extends StatefulWidget {
  final IWebAccess webAccess;
  final IWebRequestor webRequestor;
  const HomePage(this.webAccess, this.webRequestor, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<CurrentTrackInformation>(
        getCurrentTrackInformation, makeHomePage);
  }

  Future<CurrentTrackInformation> getCurrentTrackInformation() async {
    var currentTrackJson =
        await widget.webAccess.getJsonWebData('currenttrack');
    var currentTrackId = (await widget.webRequestor
            .get<CurrentTrack>('currenttrack', deserialiseCurrentTrack))
        .currentTrackId;
    return CurrentTrackInformation('Current track $currentTrackId');
  }

  CurrentTrack deserialiseCurrentTrack(Map<String, dynamic> data) {
    return CurrentTrack(data['currentTrackId']);
  }

  Widget makeHomePage(CurrentTrackInformation currentTrackInformation) {
    return Text(currentTrackInformation.text);
  }
}
