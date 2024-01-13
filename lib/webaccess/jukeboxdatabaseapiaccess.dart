import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'package:flutter_jukebox/version.dart';
import '../../dataobjects/trackinformation.dart';
import '../dataobjects/artistinformation.dart';
import '../dataobjects/jukeboxcollection.dart';

abstract class IJukeboxDatabaseApiAccess {
  Future<TrackInformation> getTrackInformation(int trackId);
  Future<List<JukeboxCollection>> getCollections();
  Future<List<TrackInformation>> getAllTracks();
  Future<List<ArtistInformation>> getAllArtists();
}

class JukeboxDatabaseApiAccess extends IJukeboxDatabaseApiAccess {
  final IWebRequestor _webRequestor;
  JukeboxDatabaseApiAccess(this._webRequestor);

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
}
