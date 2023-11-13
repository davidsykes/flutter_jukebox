import 'dart:convert';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../potentiallibrary/webaccess/jukeboxdatabaseapiaccess.dart';

class JukeboxDatabaseApiAccessTests extends TestModule {
  late IJukeboxDatabaseApiAccess _access;
  late IWebRequestor _mockWebRequestor;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(trackInformationCanBeRetrieved),
    ];
  }

  Future<void> trackInformationCanBeRetrieved() async {
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
    }
    throw UnimplementedError();
  }
}
