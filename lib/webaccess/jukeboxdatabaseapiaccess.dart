import 'package:flutter_jukebox/dataobjects/recentlyplayedtrackdata.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../dataobjects/trackinformation.dart';
import '../dataobjects/artistinformation.dart';
import '../dataobjects/jukeboxcollection.dart';
import '../potentiallibrary/utilities/ilogger.dart';
import 'requests/settrackdeletedrequest.dart';
import 'requests/updateartistfortrackrequest.dart';

abstract class IJukeboxDatabaseApiAccess {
  Future<TrackInformation> getTrackInformation(int trackId);
  Future<List<JukeboxCollection>> getCollections();
  Future<List<TrackInformation>> getAllTracks();
  Future<List<TrackInformation>> getTracksInCollection(int collectionId);
  Future<List<ArtistInformation>> getAllArtists();
  Future<bool> updateArtistForTrack(int trackId, int artistId);
  Future<List<RecentlyPlayedTrackData>> getRecentlyPlayedTracks();
  Future<List<TrackInformation>> getDeletedTracks();
  Future<bool> unDeleteTrack(int trackId);
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
    var url = 'tracks';
    var trackInfo = _webRequestor.get<List<TrackInformation>>(
        url, deserialiseTracksInformation);

    return trackInfo;
  }

  @override
  Future<List<TrackInformation>> getDeletedTracks() {
    var url = 'deletedtracks';
    var trackInfo = _webRequestor.get<List<TrackInformation>>(
        url, deserialiseTracksInformation);

    return trackInfo;
  }

  @override
  Future<List<TrackInformation>> getTracksInCollection(int collectionId) {
    var url = 'tracks?collectionId=$collectionId';
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
    var artists =
        data['artists'].map((track) => deserialiseArtistInformation(track));

    return artists.cast<ArtistInformation>().toList();
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
    var result = await _webRequestor.postRequestOk(url, request);
    if (!result.success) {
      _logger.log('Error updating artist for track: ${result.error}');
    }
    return result.success;
  }

  @override
  Future<List<RecentlyPlayedTrackData>> getRecentlyPlayedTracks() {
    var url = 'recentlyplayedtracks?count=10';
    var tracks = _webRequestor.get(url, deserialiseRecentlyPlayedTracks);
    return tracks;
  }

  List<RecentlyPlayedTrackData> deserialiseRecentlyPlayedTracks(
      Map<String, dynamic> response) {
    var tracks = response['recentlyPlayedTracks'];
    var tracks2 = tracks.map((t) => deserialiseRecentlyPlyedTrack(t));

    return tracks2.cast<RecentlyPlayedTrackData>().toList();
  }

  RecentlyPlayedTrackData deserialiseRecentlyPlyedTrack(
      Map<String, dynamic> json) {
    var time = json['time'];
    var track = deserialiseTrackInformation(json['track']);
    return RecentlyPlayedTrackData(time, track);
  }

  @override
  Future<bool> unDeleteTrack(int trackId) async {
    var url = 'settrackdeleted';
    var request = SetTrackDeletedRequest(trackId, true);
    var result = await _webRequestor.putRequestOk(url, request);
    return result.success;
  }
}
