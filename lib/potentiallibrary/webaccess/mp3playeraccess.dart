import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../dataobjects/currenttrack.dart';

abstract class IMP3PlayerAccess {
  Future<int> getCurrentTrackId();
}

class MP3PlayerAccess extends IMP3PlayerAccess {
  final IWebRequestor _webRequestor;

  MP3PlayerAccess(this._webRequestor);

  @override
  Future<int> getCurrentTrackId() async {
    var currentTrack = await _webRequestor.get<CurrentTrack>(
        'currenttrack', deserialiseCurrentTrack);

    return currentTrack.currentTrackId;
  }

  CurrentTrack deserialiseCurrentTrack(Map<String, dynamic> data) {
    return CurrentTrack(data['currentTrackId']);
  }
}
