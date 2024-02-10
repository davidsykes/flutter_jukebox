import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';
import 'jukeboxdatabaseapiaccess.dart';

abstract class ITrackCollectionPlayer {
  Future<bool> playCollection(int collectionId);
}

class TrackCollectionPlayer extends ITrackCollectionPlayer {
  final IJukeboxDatabaseApiAccess _jukeboxDatabaseApiAccess;
  final IMP3PlayerAccess _imp3playerAccess;

  TrackCollectionPlayer(this._jukeboxDatabaseApiAccess, this._imp3playerAccess);

  @override
  Future<bool> playCollection(int collectionId) async {
    var tracksInCollection =
        await _jukeboxDatabaseApiAccess.getTracksInCollection(collectionId);

    var pathInfos = tracksInCollection
        .map((e) => e.getJukeboxTrackPathAndFileName())
        .toList();

    return _imp3playerAccess.playMp3s(pathInfos);
  }
}
