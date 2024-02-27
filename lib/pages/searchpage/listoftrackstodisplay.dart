import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';

import '../../webaccess/microservicecontroller.dart';

class ListOfTracksToDisplay {
  final IMicroServiceController microServiceController;
  late CachedValue<List<TrackInformation>> _tracks;
  int _trackType = 0;

  ListOfTracksToDisplay(this.microServiceController) {
    _tracks = CachedValue<List<TrackInformation>>(fetchTracks);
  }

  Future<List<TrackInformation>> fetchTracks() async {
    if (_trackType == 0) {
      return microServiceController.getAllTracks();
    }
    return List.empty();
  }

  Future<List<TrackInformation>> getTracks() {
    return _tracks.getData();
  }

  void reset(int trackType) {
    _trackType = trackType;
    _tracks.clearCache();
  }
}
