import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/tests/mocks/stubmp3playeraccess.dart';
import '../../dataobjects/jukeboxtrackpathandsilename.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../webaccess/trackcollectionplayer.dart';
import '../mocks/stubjukeboxdatabaseapiaccess.dart';

class TrackCollectionPlayerTests extends TestModule {
  late ITrackCollectionPlayer _player;
  late MockJukeboxDatabaseApiAccess _mockJukeboxDatabaseApiAccess;
  late MockMP3PlayerAccess _mockMP3PlayerAccess;
  int collectionId = 126;
  late List<int> _tracksInCollection;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aTrackCollectionCanBePlayed),
      createTest(ifPlayMP3sReturnsFalseThenFalseIsReturned),
    ];
  }

  Future<void> aTrackCollectionCanBePlayed() async {
    var result = await _player.playCollection(collectionId);

    assertTrue(result);
    assertEqual(getTracksPathInformation(), _mockMP3PlayerAccess.playedTracks);
  }

  Future<void> ifPlayMP3sReturnsFalseThenFalseIsReturned() async {
    _mockMP3PlayerAccess.returnValue = false;
    var result = await _player.playCollection(collectionId);

    assertFalse(result);
  }

  // Support Code

  @override
  void setUpData() {
    _tracksInCollection = [1, 3, 7, 100];
  }

  @override
  void setUpMocks() {
    _mockJukeboxDatabaseApiAccess =
        MockJukeboxDatabaseApiAccess(collectionId, getTracksInformation());
    _mockMP3PlayerAccess = MockMP3PlayerAccess();
  }

  @override
  void setUpObjectUnderTest() {
    _player = TrackCollectionPlayer(
        _mockJukeboxDatabaseApiAccess, _mockMP3PlayerAccess);
  }

  List<TrackInformation> getTracksInformation() {
    return _tracksInCollection
        .map((e) => TrackInformation(e, 'trackName', 'track${e}FileName',
            e * 10, 'albumName', 'album${e}Path', e * 100, 'artistName'))
        .toList();
  }

  List<JukeboxTrackPathAndFileName> getTracksPathInformation() {
    return _tracksInCollection
        .map((e) => JukeboxTrackPathAndFileName(
            e, 'album${e}Path', 'track${e}FileName'))
        .toList();
  }
}

class MockJukeboxDatabaseApiAccess extends StubJukeboxDatabaseApiAccess {
  final int _collectionId;
  final List<TrackInformation> _tracksInCollection;

  MockJukeboxDatabaseApiAccess(this._collectionId, this._tracksInCollection);

  @override
  Future<List<TrackInformation>> getTracksInCollection(int collectionId) async {
    if (collectionId == _collectionId) {
      return _tracksInCollection;
    } else {
      throw ('Invalid collection id');
    }
  }
}

class MockMP3PlayerAccess extends StubMP3PlayerAccess {
  bool returnValue = true;
  List<JukeboxTrackPathAndFileName> playedTracks = List.empty();

  @override
  Future<bool> playMp3s(List<JukeboxTrackPathAndFileName> tracks) async {
    playedTracks = tracks;
    return returnValue;
  }
}
