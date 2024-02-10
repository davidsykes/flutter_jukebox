import 'package:flutter_jukebox/dataobjects/artistinformation.dart';
import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';

class StubJukeboxDatabaseApiAccess extends IJukeboxDatabaseApiAccess {
  @override
  Future<List<ArtistInformation>> getAllArtists() {
    throw UnimplementedError();
  }

  @override
  Future<List<TrackInformation>> getAllTracks() {
    throw UnimplementedError();
  }

  @override
  Future<List<JukeboxCollection>> getCollections() {
    throw UnimplementedError();
  }

  @override
  Future<TrackInformation> getTrackInformation(int trackId) {
    throw UnimplementedError();
  }

  @override
  Future<List<TrackInformation>> getTracksInCollection(int collectionId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateArtistForTrack(int trackId, int artistId) {
    throw UnimplementedError();
  }
}
