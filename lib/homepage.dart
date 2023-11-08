import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';

import 'currenttrackinformation.dart';
import 'potentiallibrary/widgets/futurebuilder.dart';

class HomePage extends StatefulWidget {
  final IWebAccess webAccess;
  const HomePage(this.webAccess, {super.key});

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
    var text = await widget.webAccess.getJsonWebData('currenttrack');
    return CurrentTrackInformation('text');
  }

  Widget makeHomePage(CurrentTrackInformation currentTrackInformation) {
    return Text(currentTrackInformation.text);
  }
}
