import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';

class CurrentlyPlayingTrackInformationFetcher {
  late CachedValue<TrackInformation?> _info;

  CurrentlyPlayingTrackInformationFetcher(
      Future<TrackInformation?> Function() fetchData) {
    _info = CachedValue<TrackInformation?>(fetchData);
  }

  Future<CurrentlyPlayingTrackInformation> getData() async {
    return CurrentlyPlayingTrackInformation(await _info.getData());
  }

  void reset() {
    _info.clearCache();
  }
}

class CurrentlyPlayingTrackInformation {
  final TrackInformation? info;

  CurrentlyPlayingTrackInformation(this.info);
}
