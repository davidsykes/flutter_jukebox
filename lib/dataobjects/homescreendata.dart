import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'cachedcurrentlyplayingtrackinformation.dart';

class HomeScreenData {
  final CurrentlyPlayingTrackInformationFetcher currentTrackInformation;
  final List<JukeboxCollection> jukeboxCollections;

  HomeScreenData(this.jukeboxCollections, this.currentTrackInformation);
}
