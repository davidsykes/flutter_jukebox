import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';
import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';

import '../dataobjects/artistinformation.dart';
import '../dataobjects/jukeboxcollection.dart';

abstract class IServiceController {
  Future<TrackInformation?> getCurrentTrackInformation();
  Future<List<JukeboxCollection>> getJukeboxCollections();
  Future<List<TrackInformation>> getAllTracks();
  Future<List<ArtistInformation>> getAllArtists();
}

class ServiceController extends IServiceController {
  final IJukeboxDatabaseApiAccess _dbAccess;
  final IMP3PlayerAccess _mp3PlayerAccess;

  ServiceController(this._dbAccess, this._mp3PlayerAccess);

  @override
  Future<TrackInformation?> getCurrentTrackInformation() async {
    var currentTrackId = await _mp3PlayerAccess.getCurrentTrackId();
    if (currentTrackId > 0) {
      return _dbAccess.getTrackInformation(currentTrackId);
    }
    return null;
  }

  @override
  Future<List<JukeboxCollection>> getJukeboxCollections() {
    return _dbAccess.getCollections();
  }

  @override
  Future<List<TrackInformation>> getAllTracks() {
    return _dbAccess.getAllTracks();
  }

  @override
  Future<List<ArtistInformation>> getAllArtists() {
    return _dbAccess.getAllArtists();
  }
}
