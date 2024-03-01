import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import '../../webaccess/microservicecontroller.dart';
import 'searchpagetracklisttype.dart';

class ListOfTracksToDisplay {
  final IMicroServiceController microServiceController;
  late CachedValue<List<TrackInformation>> _tracks;
  SearchPageTrackListTypeOption _trackType =
      SearchPageTrackListTypeOption.allTracks;

  ListOfTracksToDisplay(this.microServiceController) {
    _tracks = CachedValue<List<TrackInformation>>(fetchTracks);
  }

  Future<List<TrackInformation>> fetchTracks() async {
    if (_trackType == SearchPageTrackListTypeOption.allTracks) {
      return microServiceController.getAllTracks();
    }
    if (_trackType == SearchPageTrackListTypeOption.deletedTracks) {
      return microServiceController.getDeletedTracks();
    }
    return List.empty();
  }

  Future<List<TrackInformation>> getTracks() {
    return _tracks.getData();
  }

  void reset(SearchPageTrackListTypeOption trackType) {
    _trackType = trackType;
    _tracks.clearCache();
  }
}
