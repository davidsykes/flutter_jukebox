import 'dart:convert';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../webaccess/mp3playeraccess.dart';

class MP3PlayerAccessTests extends TestModule {
  late IMP3PlayerAccess _access;
  late IWebRequestor _mockMp3WebRequestor;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theCurrentTrackCanBeRequested),
    ];
  }

  Future<void> theCurrentTrackCanBeRequested() async {
    var trackId = await _access.getCurrentTrackId();

    assertEqual(5411, trackId);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockMp3WebRequestor = MockMp3WebRequestor();
  }

  @override
  void setUpObjectUnderTest() {
    _access = MP3PlayerAccess(_mockMp3WebRequestor, 0);
  }
}

class MockMp3WebRequestor extends IWebRequestor {
  @override
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise) async {
    if (url == 'currenttrack') {
      var data = jsonDecode('''{
    "currentTrackId": 5411
  }''');
      var obj = deserialise(data);
      return obj;
    }
    throw UnimplementedError();
  }

  @override
  Future<String> post(String url, dynamic request) {
    throw UnimplementedError();
  }
}
