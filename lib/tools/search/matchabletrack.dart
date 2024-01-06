import '../../dataobjects/trackinformation.dart';

class MatchableTrack {
  late String trackName;
  TrackInformation track;
  MatchableTrack(this.track) {
    trackName = track.trackName;
  }
}
