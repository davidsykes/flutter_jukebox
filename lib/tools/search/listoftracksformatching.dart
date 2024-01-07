import '../../dataobjects/trackinformation.dart';
import 'matchabletrack.dart';
import 'trackmatcher.dart';
import 'trackmatchparameters.dart';

abstract class IListOfTracksForMatching {
  List<TrackInformation> getTracks(TrackMatchParameters searchParameters);
}

class ListOfTracksForMatching extends IListOfTracksForMatching {
  ITrackMatcher trackMatcher;
  late List<MatchableTrack> _tracks;

  ListOfTracksForMatching(List<TrackInformation> tracks, this.trackMatcher) {
    _tracks = tracks.map((track) => MatchableTrack(track)).toList();
  }

  @override
  List<TrackInformation> getTracks(TrackMatchParameters searchParameters) {
    var searchText = searchParameters.searchText;
    searchText = searchText.toLowerCase();

    return _tracks
        .where((s) => searchMatches(s, searchParameters))
        .map((t) => t.track)
        .toList();
  }

  bool searchMatches(MatchableTrack track, TrackMatchParameters parameters) {
    return trackMatcher.matches(track, parameters);
  }
}
