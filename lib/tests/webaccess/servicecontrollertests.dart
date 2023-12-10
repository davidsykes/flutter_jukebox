import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';
import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';
import '../../dataobjects/trackinformation.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../webaccess/servicecontroller.dart';

class ServiceControllerTests extends TestModule {
  late IServiceController _controller;

  late IJukeboxDatabaseApiAccess _mockDbAccess;
  late MockPlayerAccess _mockPlayerAccess;

  late List<JukeboxCollection> _testCollections;
  late List<TrackInformation> _testTracks;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest('current track', theCurrentTrackCanBeRequested),
      createTest('null if no track',
          getCurrentTrackInformationReturnsNullifNoTrackIsPlaying),
      createTest('get collections', testGetJukeboxCollections),
      createTest('call get all tracks', getAllTracksCallsDbApiGetAllTracks),
    ];
  }

  Future<void> theCurrentTrackCanBeRequested() async {
    var trackInfoFuture = _controller.getCurrentTrackInformation();
    var trackInfo = await trackInfoFuture;

    assertEqual(_testTracks[0], trackInfo);
  }

  Future<void> getCurrentTrackInformationReturnsNullifNoTrackIsPlaying() async {
    _mockPlayerAccess.currentPlayingTrackId = 0;
    var trackInfo = await _controller.getCurrentTrackInformation();

    assertTrue(trackInfo == null);
  }

  Future<void> testGetJukeboxCollections() async {
    var collectionsFuture = _controller.getJukeboxCollections();
    var collections = await collectionsFuture;

    assertEqual(_testCollections, collections);
  }

  Future<void> getAllTracksCallsDbApiGetAllTracks() async {
    var allTracks = await _controller.getAllTracks();

    assertEqual(_testTracks, allTracks);
  }

  // Support Code

  @override
  void setUpData() {
    _testCollections = [
      JukeboxCollection(1, 'first'),
      JukeboxCollection(2, 'second'),
    ];
    _testTracks = [
      TrackInformation(
          1, 'Track 1', 'file name', 34, 'album', 'album path', 56, 'artist'),
      TrackInformation(
          2, 'Track 2', 'file name', 34, 'album', 'album path', 56, 'artist'),
      TrackInformation(
          3, 'Track 3', 'file name', 34, 'album', 'album path', 56, 'artist'),
    ];
  }

  @override
  void setUpMocks() {
    _mockDbAccess = MockDbAccess(_testTracks, _testCollections);
    _mockPlayerAccess = MockPlayerAccess();
  }

  @override
  void setUpObjectUnderTest() {
    _controller = ServiceController(_mockDbAccess, _mockPlayerAccess);
  }
}

class MockDbAccess extends IJukeboxDatabaseApiAccess {
  final List<JukeboxCollection> testCollections;
  final List<TrackInformation> _testTracks;
  MockDbAccess(this._testTracks, this.testCollections);

  @override
  Future<List<JukeboxCollection>> getCollections() {
    return Future<List<JukeboxCollection>>.value(testCollections);
  }

  @override
  Future<TrackInformation> getTrackInformation(int trackId) {
    if (trackId == 12) {
      return Future<TrackInformation>.value(_testTracks[0]);
    }
    throw UnimplementedError();
  }

  @override
  Future<List<TrackInformation>> getAllTracks() {
    return Future<List<TrackInformation>>.value(_testTracks);
  }
}

class MockPlayerAccess extends IMP3PlayerAccess {
  int currentPlayingTrackId = 12;

  @override
  Future<int> getCurrentTrackId() {
    return Future<int>.value(currentPlayingTrackId);
  }
}
