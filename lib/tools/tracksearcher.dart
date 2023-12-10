import '../dataobjects/trackinformation.dart';

abstract class ITrackSearcher {
  List<String> getTracks(String searchText);
}

class TrackSearcher extends ITrackSearcher {
  late List<String> _tracks;

  TrackSearcher(List<TrackInformation> tracks) {
    _tracks = tracks.map((track) => trackToText(track)).toList();
  }

  String trackToText(TrackInformation track) {
    return track.trackName;
  }

  @override
  List<String> getTracks(String searchText) {
    return _tracks.where((s) => stringMatches(s, searchText)).toList();
  }

  stringMatches(String track, String searchText) {
    return track.contains(searchText);
  }
}
