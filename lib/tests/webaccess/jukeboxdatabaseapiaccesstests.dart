import 'dart:convert';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../potentiallibrary/utilities/ilogger.dart';
import '../../potentiallibrary/webaccess/webrapiresponse.dart';
import '../../webaccess/jukeboxdatabaseapiaccess.dart';

class JukeboxDatabaseApiAccessTests extends TestModule {
  late IJukeboxDatabaseApiAccess _access;
  late MockWebRequestor _mockWebRequestor;
  late MockLogger _mockLogger;
  final _tracksInCollection = [1, 12, 16, 87];

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(individualTrackInformationCanBeRetrieved),
      createTest(allTrackInformationCanBeRetrieved),
      createTest(tracksInACollectionCanBeRetrieved),
      createTest(allArtistsCanBeRetrieved),
      createTest(updateArtistForTrackPostsTheUpdate),
      createTest(updateArtistForTrackLogsErrors),
      createTest(recentlyPlayedTracksCanBeRetrieved),
      createTest(aTrackCanBeUnDeleted),
    ];
  }

  Future<void> individualTrackInformationCanBeRetrieved() async {
    var trackInfo = await _access.getTrackInformation(123);

    assertEqual(900, trackInfo.trackId);
    assertEqual('Hotel California', trackInfo.trackName);
    assertEqual('Hotel California.mp3', trackInfo.trackFileName);
    assertEqual(60, trackInfo.albumId);
    assertEqual('The Very Best Of The Eagles', trackInfo.albumName);
    assertEqual('The Very Best Of The Eagles', trackInfo.albumPath);
    assertEqual(148, trackInfo.artistId);
    assertEqual('The Eagles', trackInfo.artistName);
  }

  Future<void> allTrackInformationCanBeRetrieved() async {
    var trackInfo = await _access.getAllTracks();

    assertEqual(3, trackInfo.length);
    assertEqual('Track 1', trackInfo[0].trackName);
    assertEqual('Track 2', trackInfo[1].trackName);
    assertEqual('Track 3', trackInfo[2].trackName);
  }

  Future<void> tracksInACollectionCanBeRetrieved() async {
    _mockWebRequestor.expectedGetUrl = 'tracks?collectionId=101';
    _mockWebRequestor.getResponse =
        makeJsonForTestTracks('Collection', _tracksInCollection);

    var trackInfo = await _access.getTracksInCollection(101);

    assertEqual(4, trackInfo.length);
    assertEqual('Collection Track 1', trackInfo[0].trackName);
    assertEqual('Collection Track 12', trackInfo[1].trackName);
    assertEqual('Collection Track 16', trackInfo[2].trackName);
    assertEqual('Collection Track 87', trackInfo[3].trackName);
  }

  Future<void> allArtistsCanBeRetrieved() async {
    var artistInfo = await _access.getAllArtists();

    assertEqual(3, artistInfo.length);
    assertEqual('Artist 1', artistInfo[0].name);
    assertEqual('Artist 2', artistInfo[1].name);
    assertEqual('Artist 3', artistInfo[2].name);
  }

  Future<void> updateArtistForTrackPostsTheUpdate() async {
    var result = await _access.updateArtistForTrack(17, 82);

    assertEqual(true, result);
    assertEqual('post', _mockWebRequestor.requestType);
    assertEqual('updateartistfortrack', _mockWebRequestor.requestUrl);
    assertEqual(17, _mockWebRequestor.request.trackId);
    assertEqual(82, _mockWebRequestor.request.artistId);
  }

  Future<void> updateArtistForTrackLogsErrors() async {
    _mockWebRequestor.requestError = 'Oops';
    await _access.updateArtistForTrack(17, 82);

    assertEqual(['Error updating artist for track: Oops'], _mockLogger.logs);
  }

  Future<void> recentlyPlayedTracksCanBeRetrieved() async {
    var tracks = await _access.getRecentlyPlayedTracks();

    assertEqual(3, tracks.length);
    assertEqual('Boots', tracks[0].track.trackName);
    assertEqual('2024-02-14T08:01:58', tracks[0].time);
    assertEqual('On A Night Like This', tracks[1].track.trackName);
    assertEqual('2024-02-14T07:58:24', tracks[1].time);
    assertEqual('Let It Be Love', tracks[2].track.trackName);
    assertEqual('2024-02-14T07:55:00', tracks[2].time);
  }

  Future<void> aTrackCanBeUnDeleted() async {
    var result = await _access.unDeleteTrack(149);

    assertEqual(true, result);
    assertEqual('put', _mockWebRequestor.requestType);
    assertEqual('settrackdeleted', _mockWebRequestor.requestUrl);
    assertEqual(149, _mockWebRequestor.request.trackId);
    assertEqual(true, _mockWebRequestor.request.isDeleted);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockWebRequestor = MockWebRequestor();
    _mockLogger = MockLogger();
  }

  @override
  void setUpObjectUnderTest() {
    _access = JukeboxDatabaseApiAccess(_mockWebRequestor, _mockLogger);
  }

  String makeJsonForTestTracks(String prefix, List<int> tracks) {
    var data = tracks
        .map((e) => TrackInformation(e, '$prefix Track $e', 'file $e', e * 10,
            'album $e', 'path $e', e * 100, 'artist $e'))
        .toList();
    var tracksJson = jsonEncode(data);
    return '{"tracks": $tracksJson}';
  }
}

class MockWebRequestor extends IWebRequestor {
  String expectedGetUrl = '';
  String getResponse = '';
  String requestType = '';
  String requestUrl = '';
  dynamic request = '';
  String? requestError;

  @override
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise) async {
    var dataJson = getTestDataForUrl(url);
    var data = jsonDecode(dataJson);
    var obj = deserialise(data);
    return obj;
  }

  String getTestDataForUrl(String url) {
    if (url == expectedGetUrl) {
      return getResponse;
    } else if (url == 'tracks?trackId=123') {
      return individualTrackResponse();
    } else if (url == 'tracks') {
      return multipleTracksResponse();
    } else if (url == 'artists') {
      return artistsResponse();
    } else if (url == 'recentlyplayedtracks?count=10') {
      return recentlyPlayedTracksResponse();
    }
    throw AssertionError('invalid url');
  }

  @override
  Future<TResponse> postRequestResponse<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse) async {
    throw AssertionError();
  }

  @override
  Future<WebApiResponse> postRequestOk<TRequest>(
      String url, TRequest request) async {
    requestType = 'post';
    requestUrl = url;
    this.request = request;
    return WebApiResponse(requestError);
  }

  @override
  Future<WebApiResponse> putRequestOk<TRequest>(
      String url, TRequest request) async {
    requestType = 'put';
    requestUrl = url;
    this.request = request;
    return WebApiResponse(requestError);
  }

  String individualTrackResponse() {
    return '''{
    "tracks": [
      {
        "trackId": 900,
        "trackName": "Hotel California",
        "trackFileName": "Hotel California.mp3",
        "albumId": 60,
        "albumName": "The Very Best Of The Eagles",
        "albumPath": "The Very Best Of The Eagles",
        "artistId": 148,
        "artistName": "The Eagles"
      }
    ]
  }''';
  }

  String multipleTracksResponse() {
    return '''{
    "tracks": [
      {
        "trackId": 900,
        "trackName": "Track 1",
        "trackFileName": "Hotel California.mp3",
        "albumId": 60,
        "albumName": "The Very Best Of The Eagles",
        "albumPath": "The Very Best Of The Eagles",
        "artistId": 148,
        "artistName": "The Eagles"
      },{
        "trackId": 900,
        "trackName": "Track 2",
        "trackFileName": "Hotel California.mp3",
        "albumId": 60,
        "albumName": "The Very Best Of The Eagles",
        "albumPath": "The Very Best Of The Eagles",
        "artistId": 148,
        "artistName": "The Eagles"
      },{
        "trackId": 900,
        "trackName": "Track 3",
        "trackFileName": "Hotel California.mp3",
        "albumId": 60,
        "albumName": "The Very Best Of The Eagles",
        "albumPath": "The Very Best Of The Eagles",
        "artistId": 148,
        "artistName": "The Eagles"
      }
    ]
  }''';
  }

  String artistsResponse() {
    return '''{
    "artists": [
      {
        "artistId": 1,
        "artistName": "Artist 1"
      },
      {
        "artistId": 2,
        "artistName": "Artist 2"
      },
      {
        "artistId": 3,
        "artistName": "Artist 3"
      }
    ]
  }''';
  }

  String recentlyPlayedTracksResponse() {
    return '''{
    "recentlyPlayedTracks": [
      {
        "time": "2024-02-14T08:01:58",
        "track": {
          "trackId": 10265,
          "trackName": "Boots",
          "trackFileName": "10 - Boots.mp3",
          "albumId": 577,
          "albumName": "Ocean",
          "albumPath": "Lady Antebellum/Ocean",
          "artistId": 1896,
          "artistName": "Lady Antebellum"
        }
      },
      {
        "time": "2024-02-14T07:58:24",
        "track": {
          "trackId": 10264,
          "trackName": "On A Night Like This",
          "trackFileName": "09 - On A Night Like This.mp3",
          "albumId": 577,
          "albumName": "Ocean",
          "albumPath": "Lady Antebellum/Ocean",
          "artistId": 1896,
          "artistName": "Lady Antebellum"
        }
      },
      {
        "time": "2024-02-14T07:55:00",
        "track": {
          "trackId": 10263,
          "trackName": "Let It Be Love",
          "trackFileName": "08 - Let It Be Love.mp3",
          "albumId": 577,
          "albumName": "Ocean",
          "albumPath": "Lady Antebellum/Ocean",
          "artistId": 1896,
          "artistName": "Lady Antebellum"
        }
      }
    ]}''';
  }
}

class MockLogger extends ILogger {
  var logs = List<String>.empty(growable: true);
  @override
  void log(String log) {
    logs.add(log);
  }
}
