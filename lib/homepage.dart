import 'package:flutter/material.dart';

import 'currenttrackinformation.dart';
import 'potentiallibrary/widgets/futurebuilder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    return CurrentTrackInformation();
  }

  Widget makeHomePage(CurrentTrackInformation currentTrackInformation) {
    return const Text('afdsfafasfsdaf!!!');
  }
}
