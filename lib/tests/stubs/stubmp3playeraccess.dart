import 'package:flutter_jukebox/dataobjects/jukeboxtrackpathandsilename.dart';
import '../../webaccess/mp3playeraccess.dart';

class StubMP3PlayerAccess extends IMP3PlayerAccess {
  @override
  Future<int> getCurrentTrackId() {
    throw UnimplementedError();
  }

  @override
  Future<bool> playMp3s(List<JukeboxTrackPathAndFileName> tracks) {
    throw UnimplementedError();
  }

  @override
  Future<bool> clearPlaylist() {
    throw UnimplementedError();
  }
}
