import '../dataobjects/trackinformation.dart';

abstract class ITrackSearcher {
  List<TrackInformation> getTracks(String searchText);
}

class SearchItem {
  String searchText;
  TrackInformation track;
  SearchItem(this.searchText, this.track);
}

class TrackSearcher extends ITrackSearcher {
  late List<SearchItem> _tracks;

  TrackSearcher(List<TrackInformation> tracks) {
    _tracks = tracks.map((track) => trackToSearchItem(track)).toList();
  }

  SearchItem trackToSearchItem(TrackInformation track) {
    var searchText = trackToText(track).toLowerCase();
    return SearchItem(searchText, track);
  }

  String trackToText(TrackInformation track) {
    return track.trackName + track.albumName + track.artistName;
  }

  @override
  List<TrackInformation> getTracks(String searchText) {
    searchText = searchText.toLowerCase();
    return _tracks
        .where((s) => stringMatches(s.searchText, searchText))
        .map((t) => t.track)
        .toList();
  }

  stringMatches(String track, String searchText) {
    return track.contains(searchText);
  }
}
