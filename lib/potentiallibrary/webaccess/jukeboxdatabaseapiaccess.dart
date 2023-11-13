import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../dataobjects/trackinformation.dart';

abstract class IJukeboxDatabaseApiAccess {
  Future<TrackInformation> getTrackInformation(int trackId);
}

class JukeboxDatabaseApiAccess extends IJukeboxDatabaseApiAccess {
  final IWebRequestor _webRequestor;
  JukeboxDatabaseApiAccess(this._webRequestor);

  @override
  Future<TrackInformation> getTrackInformation(int trackId) async {
    var url = 'tracks?trackId=$trackId';
    var trackInfo =
        _webRequestor.get<TrackInformation>(url, deserialiseTrackInformation);

    return trackInfo;
  }

  TrackInformation deserialiseTrackInformation(Map<String, dynamic> data) {
    var tracks = data['tracks'];
    var track = tracks[0];
    return TrackInformation(
        track['trackId'],
        track['trackName'],
        track['trackFileName'],
        track['albumId'],
        track['albumName'],
        track['albumPath'],
        track['artistId'],
        track['artistName']);
  }
}
