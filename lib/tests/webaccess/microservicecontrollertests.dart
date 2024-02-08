import 'package:flutter_jukebox/dataobjects/artistinformation.dart';
import 'package:flutter_jukebox/dataobjects/jukeboxcollection.dart';
import 'package:flutter_jukebox/dataobjects/jukeboxtrackpathandsilename.dart';
import 'package:flutter_jukebox/webaccess/jukeboxdatabaseapiaccess.dart';
import 'package:flutter_jukebox/webaccess/mp3playeraccess.dart';
import 'package:flutter_jukebox/webaccess/trackcollectionplayer.dart';
import '../../dataobjects/trackinformation.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../webaccess/microservicecontroller.dart';

class MicroServiceControllerTests extends TestModule {
  late IMicroServiceController _controller;

  late MockDbAccess _mockDbAccess;
  late MockPlayerAccess _mockPlayerAccess;

  late List<JukeboxCollection> _testCollections;
  late List<TrackInformation> _testTracks;
  late List<ArtistInformation> _testArtists;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theCurrentTrackCanBeRequested),
      createTest(getCurrentTrackInformationReturnsNullifNoTrackIsPlaying),
      createTest(testGetJukeboxCollections),
      createTest(getAllTracksCallsDbApiGetAllTracks),
      createTest(getAllArtistsCallsDbApiGetAllArtists),
      createTest(updateArtistForTrack),
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

  Future<void> getAllArtistsCallsDbApiGetAllArtists() async {
    var artists = await _controller.getAllArtists();

    assertEqual(_testArtists, artists);
  }

  Future<void> updateArtistForTrack() async {
    _controller.updateArtistForTrack(12, 34);

    assertEqual(12, _mockDbAccess.updatedTrackId);
    assertEqual(34, _mockDbAccess.updatedArtistId);
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
    _testArtists = [
      ArtistInformation(1, 'artist 1'),
      ArtistInformation(1, 'artist 2'),
    ];
  }

  @override
  void setUpMocks() {
    _mockDbAccess = MockDbAccess(_testTracks, _testCollections, _testArtists);
    _mockPlayerAccess = MockPlayerAccess();
  }

  @override
  void setUpObjectUnderTest() {
    _controller = MicroServiceController(
        _mockDbAccess, _mockPlayerAccess, MockTrackCollectionPlayer());
  }
}

class MockDbAccess extends IJukeboxDatabaseApiAccess {
  final List<JukeboxCollection> collections;
  final List<TrackInformation> tracks;
  final List<ArtistInformation> artists;
  int updatedTrackId = 0;
  int updatedArtistId = 0;
  MockDbAccess(this.tracks, this.collections, this.artists);

  @override
  Future<List<JukeboxCollection>> getCollections() {
    return Future<List<JukeboxCollection>>.value(collections);
  }

  @override
  Future<TrackInformation> getTrackInformation(int trackId) {
    if (trackId == 12) {
      return Future<TrackInformation>.value(tracks[0]);
    }
    throw UnimplementedError();
  }

  @override
  Future<List<TrackInformation>> getAllTracks() {
    return Future<List<TrackInformation>>.value(tracks);
  }

  @override
  Future<List<ArtistInformation>> getAllArtists() {
    return Future<List<ArtistInformation>>.value(artists);
  }

  @override
  Future<bool> updateArtistForTrack(int trackId, int artistId) {
    updatedTrackId = trackId;
    updatedArtistId = artistId;
    return Future<bool>.value(true);
  }
}

class MockPlayerAccess extends IMP3PlayerAccess {
  int currentPlayingTrackId = 12;

  @override
  Future<int> getCurrentTrackId() {
    return Future<int>.value(currentPlayingTrackId);
  }

  @override
  Future<bool> playMp3(JukeboxTrackPathAndFileName track) {
    throw UnimplementedError();
  }
}

class MockTrackCollectionPlayer extends ITrackCollectionPlayer {
  @override
  Future<bool> playCollection(int collectionId) {
    throw UnimplementedError();
  }
}
