import 'package:flutter_jukebox/dataobjects/artistinformation.dart';
import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'package:flutter_jukebox/dataobjects/jukeboxtrackpathandsilename.dart';
import 'package:flutter_jukebox/dataobjects/recentlyplayedtrackdata.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../dataobjects/albuminformation.dart';
import '../../webaccess/microservicecontroller.dart';

class StubMicroServiceController extends IMicroServiceController {
  @override
  Future<List<ArtistInformation>> getAllArtists() {
    throw UnimplementedError();
  }

  @override
  Future<List<TrackInformation>> getAllTracks() {
    throw UnimplementedError();
  }

  @override
  Future<TrackInformation?> getCurrentTrackInformation() {
    throw UnimplementedError();
  }

  @override
  Future<List<JukeboxCollection>> getJukeboxCollections() {
    throw UnimplementedError();
  }

  @override
  Future<bool> playCollection(int collectionId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> playMp3s(List<JukeboxTrackPathAndFileName> tracks) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateArtistForTrack(int trackId, int artistId) {
    throw UnimplementedError();
  }

  @override
  Future<List<RecentlyPlayedTrackData>> getRecentlyPlayedTracks() {
    throw UnimplementedError();
  }

  @override
  Future<List<TrackInformation>> getDeletedTracks() {
    throw UnimplementedError();
  }

  @override
  Future<bool> unDeleteTrack(int trackId) {
    throw UnimplementedError();
  }

  @override
  Future<bool> clearPlaylist() {
    throw UnimplementedError();
  }

  @override
  Future<bool> playRandomTrack() {
    throw UnimplementedError();
  }

  @override
  Future<List<AlbumInformation>> getAllAlbums() {
    throw UnimplementedError();
  }
}
