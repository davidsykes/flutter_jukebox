import 'package:flutter_jukebox/dataobjects/jukeboxtrackpathandsilename.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../dataobjects/currenttrack.dart';
import 'requests/mp3playerplaytracksrequest.dart';

abstract class IMP3PlayerAccess {
  Future<int> getCurrentTrackId();
  Future<bool> playMp3(JukeboxTrackPathAndFileName track);
}

class MP3PlayerAccess extends IMP3PlayerAccess {
  final IWebRequestor _webRequestor;
  final int currentlyPlayingTrackId;

  MP3PlayerAccess(this._webRequestor, this.currentlyPlayingTrackId);

  @override
  Future<int> getCurrentTrackId() async {
    if (currentlyPlayingTrackId > 0) {
      return currentlyPlayingTrackId;
    }

    var currentTrack = await _webRequestor.get<CurrentTrack>(
        'currenttrack', deserialiseCurrentTrack);

    return currentTrack.currentTrackId;
  }

  CurrentTrack deserialiseCurrentTrack(Map<String, dynamic> data) {
    return CurrentTrack(data['currentTrackId']);
  }

  @override
  Future<bool> playMp3(JukeboxTrackPathAndFileName track) async {
    var request = MP3PlayerPlayTracksRequest([track]);
    var result = await _webRequestor.postRequestOk('playtracks', request);
    return result.success;
  }
}
