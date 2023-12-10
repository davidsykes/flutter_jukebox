import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../dataobjects/trackinformation.dart';
import '../dataobjects/jukeboxcollection.dart';

abstract class IJukeboxDatabaseApiAccess {
  Future<TrackInformation> getTrackInformation(int trackId);
  Future<List<JukeboxCollection>> getCollections();
  Future<List<TrackInformation>> getAllTracks();
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

  @override
  Future<List<TrackInformation>> getAllTracks() {
    var url = 'tracks';
    var trackInfo = _webRequestor.get<List<TrackInformation>>(
        url, deserialiseTracksInformation);

    return trackInfo;
  }
}
