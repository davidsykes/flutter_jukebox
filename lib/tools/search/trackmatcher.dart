import 'package:flutter_jukebox/tools/search/matchabletrack.dart';
import 'trackmatchparameters.dart';

abstract class ITrackMatcher {
  bool matches(MatchableTrack track, TrackMatchParameters sp);
}

class TrackMatcher extends ITrackMatcher {
  @override
  bool matches(MatchableTrack track, TrackMatchParameters sp) {
    if (track.trackName.contains(sp.searchText)) {
      return true;
    }
    // TODO: implement matches
    throw UnimplementedError();
  }
}

// TODO: create search text, artist, album, track all lower case