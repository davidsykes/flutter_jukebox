import '../../dataobjects/jukeboxtrackpathandsilename.dart';

class MP3PlayerPlayTracksRequest {
  List<JukeboxTrackPathAndFileName> tracksToPlay;

  MP3PlayerPlayTracksRequest(this.tracksToPlay);

  Map<String, dynamic> toJson() {
    return {
      'TracksToPlay': tracksToPlay,
    };
  }
}
