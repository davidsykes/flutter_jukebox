import 'package:flutter/material.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import '../../dataobjects/cachedcurrentlyplayingtrackinformation.dart';
import '../../dataobjects/homescreendata.dart';
import '../../dataobjects/trackinformation.dart';
import '../../potentiallibrary/programexception.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';
import '../../tools/logger.dart';
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
  CurrentlyPlayingTrackInformationFetcher? currentTrackInformationFuture;

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<HomeScreenData>(
        dataFetcher: getHomeScreenInformation(), pageMaker: makeHomePage);
  }

  Future<HomeScreenData> getHomeScreenInformation() async {
    try {
      currentTrackInformationFuture ??= CurrentlyPlayingTrackInformationFetcher(
          widget.microServiceController.getCurrentTrackInformation);
      var jukeboxCollectionsFuture =
          widget.microServiceController.getJukeboxCollections();

      var homeScreen = HomeScreenData(
          await jukeboxCollectionsFuture, currentTrackInformationFuture!);
      return homeScreen;
    } on ProgramException catch (e) {
      Logger().log('an exception $e');
      return HomeScreenData(
          [],
          CurrentlyPlayingTrackInformationFetcher(
            () => Future<TrackInformation?>(() => null),
          ));
    }
  }

  Future<TrackInformation> getCurrentTrackInformation(
      int currentTrackId) async {
    try {
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

  Widget makeHomePage(HomeScreenData homeScreenInformation) {
    var rows = List<Widget>.empty(growable: true);
    rows.add(const Text(''));
    rows.add(JukeboxCollectionSelectorWidget(widget.microServiceController,
        homeScreenInformation.jukeboxCollections));
    rows.add(const Text(''));
    rows.add(CurrentlyPlayingWidget(
        homeScreenInformation.currentTrackInformation, refresh));

    return Column(
      children: rows,
    );
  }

  void refresh() {
    setState(() {});
  }
}
