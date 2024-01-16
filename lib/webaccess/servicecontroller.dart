import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';
import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';

import '../dataobjects/artistinformation.dart';
import '../dataobjects/jukeboxcollection.dart';

abstract class IServiceController {
  Future<TrackInformation?> getCurrentTrackInformation();
  Future<List<JukeboxCollection>> getJukeboxCollections();
  Future<List<TrackInformation>> getAllTracks();
  Future<List<ArtistInformation>> getAllArtists();
  Future<bool> updateArtistForTrack(int trackId, int artistId);
}

class ServiceController extends IServiceController {
  final IJukeboxDatabaseApiAccess _dbAccess;
  final IMP3PlayerAccess _mp3PlayerAccess;
  late CachedValue<List<TrackInformation>> _allTracks;

  ServiceController(this._dbAccess, this._mp3PlayerAccess) {
    _allTracks = CachedValue<List<TrackInformation>>(fetchAllTracks);
  }

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
    return _allTracks.getData();
  }

  Future<List<TrackInformation>> fetchAllTracks() {
    return _dbAccess.getAllTracks();
  }

  @override
  Future<List<ArtistInformation>> getAllArtists() {
    return _dbAccess.getAllArtists();
  }

  @override
  Future<bool> updateArtistForTrack(int trackId, int artistId) {
    return _dbAccess.updateArtistForTrack(trackId, artistId);
  }
}
