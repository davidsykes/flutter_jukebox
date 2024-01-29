import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'package:flutter_jukebox/version.dart';
import '../../dataobjects/trackinformation.dart';
import '../dataobjects/artistinformation.dart';
import '../dataobjects/jukeboxcollection.dart';
import '../potentiallibrary/utilities/ilogger.dart';
import 'requests/updatesrtistfortrack.dart';

abstract class IJukeboxDatabaseApiAccess {
  Future<TrackInformation> getTrackInformation(int trackId);
  Future<List<JukeboxCollection>> getCollections();
  Future<List<TrackInformation>> getAllTracks();
  Future<List<ArtistInformation>> getAllArtists();
  Future<bool> updateArtistForTrack(int trackId, int artistId);
}

class JukeboxDatabaseApiAccess extends IJukeboxDatabaseApiAccess {
  final IWebRequestor _webRequestor;
  final ILogger _logger;
  JukeboxDatabaseApiAccess(this._webRequestor, this._logger);

  @override
  Future<TrackInformation> getTrackInformation(int trackId) async {
    var url = 'tracks?trackId=$trackId';
    var trackInfo = await _webRequestor.get<List<TrackInformation>>(
        url, deserialiseTracksInformation);

    return trackInfo[0];
  }

  @override
  Future<List<TrackInformation>> getAllTracks() {
    if (Version().version.testAllTracks) {
      return Future<List<TrackInformation>>.value([
        TrackInformation(
            1, 'Track 1', 'file name', 34, 'album', 'album path', 56, 'artist'),
        TrackInformation(
            2, 'Track 2', 'file name', 34, 'album', 'album path', 56, 'artist'),
        TrackInformation(
            3, 'Track 3', 'file name', 34, 'album', 'album path', 56, 'artist'),
      ]);
    }
    var url = 'tracks';
    var trackInfo = _webRequestor.get<List<TrackInformation>>(
        url, deserialiseTracksInformation);

    return trackInfo;
  }

  List<TrackInformation> deserialiseTracksInformation(
      Map<String, dynamic> data) {
    var tracks = data['tracks'];
    var tracks2 = tracks.map((track) => deserialiseTrackInformation(track));

    return tracks2.cast<TrackInformation>().toList();
  }

  TrackInformation deserialiseTrackInformation(Map<String, dynamic> track) {
    return TrackInformation(
        track['trackId'],
        track['trackName'],
        track['trackFileName'],
        track['albumId'],
        track['albumName'],
        track['albumPath'],
        track['artistId'],
        track['artistName']);
  }

  @override
  Future<List<JukeboxCollection>> getCollections() {
    var url = 'collections';
    var collections = _webRequestor.get<List<JukeboxCollection>>(
        url, deserialiseJukeboxCollectionList);
    return collections;
  }

  List<JukeboxCollection> deserialiseJukeboxCollectionList(
      Map<String, dynamic> data) {
    var collections = data["collections"]
        .map((c) => JukeboxCollection(c["collectionId"], c["collectionName"]))
        .cast<JukeboxCollection>()
        .toList();
    return collections;
  }

  List<ArtistInformation> deserialiseArtistsInformation(
      Map<String, dynamic> data) {
    var tracks = data['artists'];
    var tracks2 = tracks.map((track) => deserialiseArtistInformation(track));

    return tracks2.cast<ArtistInformation>().toList();
  }

  ArtistInformation deserialiseArtistInformation(Map<String, dynamic> track) {
    return ArtistInformation(
      track['artistId'],
      track['artistName'],
    );
  }

  @override
  Future<List<ArtistInformation>> getAllArtists() {
    var url = 'artists';
    var artists = _webRequestor.get<List<ArtistInformation>>(
        url, deserialiseArtistsInformation);

    return artists;
  }

  @override
  Future<bool> updateArtistForTrack(int trackId, int artistId) async {
    var url = 'updateartistfortrack';
    var request = UpdateArtistForTrackRequest(trackId, artistId);
    var response = await _webRequestor.postApiRequest(
        url, request, UpdateArtistForTrackResponse.fromJson);
    if (response != 'Ok') {
      _logger.log('Error updating artist for track: $response');
      return false;
    }
    return true;
  }
}
