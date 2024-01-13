import 'dart:convert';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../webaccess/jukeboxdatabaseapiaccess.dart';

class JukeboxDatabaseApiAccessTests extends TestModule {
  late IJukeboxDatabaseApiAccess _access;
  late IWebRequestor _mockWebRequestor;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(individualTrackInformationCanBeRetrieved),
      createTest(allTrackInformationCanBeRetrieved),
      createTest(allArtistsCanBeRetrieved),
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

  Future<void> allArtistsCanBeRetrieved() async {
    var artistInfo = await _access.getAllArtists();

    assertEqual(3, artistInfo.length);
    assertEqual('Artist 1', artistInfo[0].name);
    assertEqual('Artist 2', artistInfo[1].name);
    assertEqual('Artist 3', artistInfo[2].name);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockWebRequestor = MockMp3WebRequestor();
  }

  @override
  void setUpObjectUnderTest() {
    _access = JukeboxDatabaseApiAccess(_mockWebRequestor);
  }
}

class MockMp3WebRequestor extends IWebRequestor {
  @override
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise) async {
    if (url == 'tracks?trackId=123') {
      var data = jsonDecode('''{
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
  }''');
      var obj = deserialise(data);
      return obj;
    } else if (url == 'tracks') {
      var data = jsonDecode('''{
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
  }''');
      var obj = deserialise(data);
      return obj;
    } else if (url == 'artists') {
      var data = jsonDecode('''{
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
  }''');
      var obj = deserialise(data);
      return obj;
    }
    throw UnimplementedError();
  }
}
