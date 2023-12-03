import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'trackinformation.dart';

class HomeScreenData {
  List<JukeboxCollection> jukeboxCollections;
  TrackInformation? trackInformation;

  HomeScreenData(this.jukeboxCollections, this.trackInformation);
}
