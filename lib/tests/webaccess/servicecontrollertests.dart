import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';
import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';

import '../../dataobjects/trackinformation.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../webaccess/servicecontroller.dart';

class ServiceControllerTests extends TestModule {
  late IServiceController _controller;
  late TrackInformation testTrackInfo;
  late IJukeboxDatabaseApiAccess _mockDbAccess;
  late IMP3PlayerAccess _mockPlayerAccess;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theCurrentTrackCanBeRequested),
    ];
  }

  Future<void> theCurrentTrackCanBeRequested() async {
    var trackInfoFuture = _controller.getCurrentTrackInformation();
    var trackInfo = await trackInfoFuture;

    assertEqual(testTrackInfo, trackInfo);
  }

  // Support Code

  @override
  void setUpData() {
    testTrackInfo = TrackInformation(
        12, 'name', 'file name', 34, 'album', 'album path', 56, 'artist');
  }

  @override
  void setUpMocks() {
    _mockDbAccess = MockDbAccess(testTrackInfo);
    _mockPlayerAccess = MockPlayerAccess();
  }

  @override
  void setUpObjectUnderTest() {
    _controller = ServiceController(_mockDbAccess, _mockPlayerAccess);
  }
}

class MockDbAccess extends IJukeboxDatabaseApiAccess {
  final TrackInformation testTrackInfo;
  MockDbAccess(this.testTrackInfo);

  @override
  Future<List<JukeboxCollection>> getCollections() {
    // TODO: implement getCollections
    throw UnimplementedError();
  }

  @override
  Future<TrackInformation> getTrackInformation(int trackId) {
    if (trackId == 12) {
      return Future<TrackInformation>.value(testTrackInfo);
    }
    throw UnimplementedError();
  }
}

class MockPlayerAccess extends IMP3PlayerAccess {
  @override
  Future<int> getCurrentTrackId() {
    return Future<int>.value(12);
  }
}
