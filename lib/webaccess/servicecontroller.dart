import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';
import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';

abstract class IServiceController {
  Future<TrackInformation> getCurrentTrackInformation();
  getJukeboxCollections();
}

class ServiceController extends IServiceController {
  final IJukeboxDatabaseApiAccess _dbAccess;
  final IMP3PlayerAccess _mp3PlayerAccess;

  ServiceController(this._dbAccess, this._mp3PlayerAccess);

  @override
  Future<TrackInformation> getCurrentTrackInformation() async {
    var currentTrackId = await _mp3PlayerAccess.getCurrentTrackId();
    return _dbAccess.getTrackInformation(currentTrackId);
  }

  @override
  getJukeboxCollections() {
    //var playListsFuture = widget.jukeboxDatabaseApiAccess.getPlayLists();
    // TODO: implement getJukeboxCollections
    throw UnimplementedError();
  }
}
