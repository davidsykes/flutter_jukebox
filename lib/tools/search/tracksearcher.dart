import '../../dataobjects/trackinformation.dart';
import 'searchitem.dart';
import 'searchparameters.dart';

abstract class ITrackSearcher {
  List<TrackInformation> getTracks(SearchParameters searchParameters);
}

class TrackSearcher extends ITrackSearcher {
  late List<SearchItem> _tracks;

  TrackSearcher(List<TrackInformation> tracks) {
    _tracks = tracks.map((track) => SearchItem(track)).toList();
  }

  @override
  List<TrackInformation> getTracks(SearchParameters searchParameters) {
    var searchText = searchParameters.searchText;
    searchText = searchText.toLowerCase();

    return _tracks
        .where((s) => searchMatches(s, searchParameters))
        .map((t) => t.track)
        .toList();
  }

  bool searchMatches(SearchItem track, SearchParameters searchText) {
    return track.searchText.contains(searchText.searchText);
  }
}
