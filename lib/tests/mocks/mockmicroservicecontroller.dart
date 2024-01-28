import 'package:flutter_jukebox/dataobjects/artistinformation.dart';
import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import '../../dataobjects/jukeboxtrackpathandsilename.dart';

class MockMicroServiceController extends IMicroServiceController {
  Future<bool> Function(int trackId, int artistId)? mockUpdateArtistForTrack;

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
  Future<bool> updateArtistForTrack(int trackId, int artistId) {
    if (mockUpdateArtistForTrack != null) {
      return mockUpdateArtistForTrack!(trackId, artistId);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> playMp3(JukeboxTrackPathAndFileName track) {
    throw UnimplementedError();
  }
}
