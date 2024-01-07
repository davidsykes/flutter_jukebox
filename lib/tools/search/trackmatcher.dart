import 'package:flutter_jukebox/tools/search/matchabletrack.dart';
import 'trackmatchparameters.dart';

abstract class ITrackMatcher {
  bool matches(MatchableTrack track, TrackMatchParameters sp);
}

class TrackMatcher extends ITrackMatcher {
  @override
  bool matches(MatchableTrack track, TrackMatchParameters sp) {
    if (requiredTextIsMissing(track.artist, sp.artist)) {
      return false;
    }

    if (track.trackName.contains(sp.searchText)) {
      return true;
    }
    if (track.artist.contains(sp.searchText)) {
      return true;
    }
    if (track.albumName.contains(sp.searchText)) {
      return true;
    }
    return false;
  }

  bool requiredTextIsMissing(String text, String? requiredText) {
    if ((requiredText != null) && (!text.contains(requiredText))) {
      return true;
    }
    return false;
  }
}
