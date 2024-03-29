import 'package:flutter_jukebox/dataobjects/albuminformation.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';
import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';
import '../dataobjects/jukeboxtrackpathandsilename.dart';
import '../dataobjects/artistinformation.dart';
import '../dataobjects/jukeboxcollection.dart';
import '../dataobjects/recentlyplayedtrackdata.dart';
import 'trackcollectionplayer.dart';

abstract class IMicroServiceController {
  Future<TrackInformation?> getCurrentTrackInformation();
  Future<List<JukeboxCollection>> getJukeboxCollections();
  Future<List<TrackInformation>> getAllTracks();
  Future<List<AlbumInformation>> getAllAlbums();
  Future<List<TrackInformation>> getDeletedTracks();
  Future<List<ArtistInformation>> getAllArtists();
  Future<bool> updateArtistForTrack(int trackId, int artistId);
  Future<bool> playMp3s(List<JukeboxTrackPathAndFileName> tracks);
  Future<bool> playCollection(int collectionId);
  Future<List<RecentlyPlayedTrackData>> getRecentlyPlayedTracks();
  Future<bool> unDeleteTrack(int trackId);
  Future<bool> clearPlaylist();
  Future<bool> playRandomTrack();
}

class MicroServiceController extends IMicroServiceController {
  final IJukeboxDatabaseApiAccess _dbAccess;
  final IMP3PlayerAccess _mp3PlayerAccess;
  final ITrackCollectionPlayer _trackCollectionPlayer;
  late CachedValue<List<TrackInformation>> _allTracks;
  late CachedValue<List<ArtistInformation>> _allArtists;

  MicroServiceController(
      this._dbAccess, this._mp3PlayerAccess, this._trackCollectionPlayer) {
    _allTracks =
        CachedValue<List<TrackInformation>>(fetchAllTracksFromTheDatabase);
    _allArtists = CachedValue<List<ArtistInformation>>(fetchAllArtists);
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

  @override
  Future<List<TrackInformation>> getDeletedTracks() {
    return _dbAccess.getDeletedTracks();
  }

  Future<List<TrackInformation>> fetchAllTracksFromTheDatabase() {
    return _dbAccess.getAllTracks();
  }

  @override
  Future<List<ArtistInformation>> getAllArtists() {
    return _allArtists.getData();
  }

  Future<List<ArtistInformation>> fetchAllArtists() {
    return _dbAccess.getAllArtists();
  }

  @override
  Future<bool> updateArtistForTrack(int trackId, int artistId) {
    return _dbAccess.updateArtistForTrack(trackId, artistId);
  }

  @override
  Future<bool> playMp3s(List<JukeboxTrackPathAndFileName> tracks) {
    return _mp3PlayerAccess.playMp3s(tracks);
  }

  @override
  Future<bool> playCollection(int collectionId) {
    return _trackCollectionPlayer.playCollection(collectionId);
  }

  @override
  Future<List<RecentlyPlayedTrackData>> getRecentlyPlayedTracks() {
    return _dbAccess.getRecentlyPlayedTracks();
  }

  @override
  Future<bool> unDeleteTrack(int trackId) {
    return _dbAccess.unDeleteTrack(trackId);
  }

  @override
  Future<bool> clearPlaylist() {
    return _mp3PlayerAccess.clearPlaylist();
  }

  @override
  Future<bool> playRandomTrack() {
    return _dbAccess.playRandomTrack();
  }

  @override
  Future<List<AlbumInformation>> getAllAlbums() {
    return _dbAccess.getAllAlbums();
  }
}
