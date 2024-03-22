import 'dart:async';
import 'dart:convert';
import 'package:flutter_jukebox/dataobjects/currenttrack.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../../dataobjects/jukeboxtrackpathandsilename.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../potentiallibrary/webaccess/webrapiresponse.dart';
import '../../webaccess/mp3playeraccess.dart';

class MP3PlayerAccessTests extends TestModule {
  late IMP3PlayerAccess _access;
  late MockMp3WebRequestor _mockMp3WebRequestor;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theCurrentTrackCanBeRequested),
      createTest(anMp3CanBePlayed),
      createTest(severalMp3sCanBePlayed),
    ];
  }

  Future<void> theCurrentTrackCanBeRequested() async {
    var trackId = await _access.getCurrentTrackId();

    assertEqual(5411, trackId);
  }

  Future<void> anMp3CanBePlayed() async {
    var track =
        JukeboxTrackPathAndFileName(123, 'track path', 'track file name');
    _mockMp3WebRequestor.postResponse = jsonEncode(CurrentTrack(123));

    await _access.playMp3s([track]);

    assertEqual('playtracks', _mockMp3WebRequestor.postUrl);
    assertEqual(
        '{"TracksToPlay":[{"Identifier":123,"TrackPath":"track path","TrackFileName":"track file name"}]}',
        _mockMp3WebRequestor.postRequest);
  }

  Future<void> severalMp3sCanBePlayed() async {
    var tracks = [
      JukeboxTrackPathAndFileName(123, 'track path', 'track file name'),
      JukeboxTrackPathAndFileName(124, 'track path', 'track file name'),
      JukeboxTrackPathAndFileName(125, 'track path', 'track file name')
    ];
    _mockMp3WebRequestor.postResponse = jsonEncode(CurrentTrack(123));

    await _access.playMp3s(tracks);

    assertEqual('playtracks', _mockMp3WebRequestor.postUrl);
    assertEqual(
        '{"TracksToPlay":[{"Identifier":123,"TrackPath":"track path","TrackFileName":"track file name"},{"Identifier":124,"TrackPath":"track path","TrackFileName":"track file name"},{"Identifier":125,"TrackPath":"track path","TrackFileName":"track file name"}]}',
        _mockMp3WebRequestor.postRequest);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockMp3WebRequestor = MockMp3WebRequestor();
  }

  @override
  void setUpObjectUnderTest() {
    _access = MP3PlayerAccess(_mockMp3WebRequestor);
  }
}

class MockMp3WebRequestor extends IWebRequestor {
  String postUrl = '';
  String postRequest = '';
  String postResponse = '';

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
    throw AssertionError();
  }

  @override
  Future<TResponse> postRequestResponse<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse) {
    postUrl = url;
    postRequest = jsonEncode(request);
    return Future(() => deserialiseResponse(jsonDecode(postResponse)));
  }

  @override
  Future<WebApiResponse> postRequestOk<TRequest>(
      String url, TRequest request) async {
    postUrl = url;
    postRequest = jsonEncode(request);
    return WebApiResponse();
  }

  @override
  Future<WebApiResponse> putRequestOk<TRequest>(String url, TRequest request) {
    throw UnimplementedError();
  }
}
