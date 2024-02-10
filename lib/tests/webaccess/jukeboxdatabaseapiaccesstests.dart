import 'dart:convert';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../potentiallibrary/utilities/ilogger.dart';
import '../../potentiallibrary/webaccess/webrequestorresponse.dart';
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
    assertEqual('updateartistfortrack', _mockWebRequestor.postUrl);
    assertEqual(17, _mockWebRequestor.postRequest.trackId);
    assertEqual(82, _mockWebRequestor.postRequest.artistId);
  }

  Future<void> updateArtistForTrackLogsErrors() async {
    _mockWebRequestor.postError = 'Oops';
    await _access.updateArtistForTrack(17, 82);

    assertEqual(['Error updating artist for track: Oops'], _mockLogger.logs);
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
  String postUrl = '';
  dynamic postRequest = '';
  String? postError;

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
    } else if (url == 'tracks') {
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
    } else if (url == 'artists') {
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
    throw AssertionError('invalid url');
  }

  @override
  Future<TResponse> postRequestResponse<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse) async {
    throw UnimplementedError();
  }

  @override
  Future<WebRequesterResponse> postRequestOk<TRequest, TResponse>(
      String url, TRequest request) async {
    postUrl = url;
    postRequest = request;
    return WebRequesterResponse(postError);
  }
}

class MockLogger extends ILogger {
  var logs = List<String>.empty(growable: true);
  @override
  void log(String log) {
    logs.add(log);
  }
}
