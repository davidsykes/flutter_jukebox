import '../../dataobjects/trackinformation.dart';

class MatchableTrack {
  late String trackName;
  late String artist;
  late String albumName;
  TrackInformation track;
  MatchableTrack(this.track) {
    trackName = track.trackName.toLowerCase();
    artist = track.artistName.toLowerCase();
    albumName = track.albumName.toLowerCase();
  }
}
