import 'package:flutter_jukebox/dataobjects/trackinformation.dart';

import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../tools/tracksearcher.dart';

class TrackSearcherTests extends TestModule {
  late ITrackSearcher _searcher;

  late List<TrackInformation> _tracks;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest('All tracks can be retrieved', allTracksCanBeRetrieved),
      createTest('A simple search', simpleSearch),
      createTest('Searches are case insensitive', searchesAreCaseInsensitive),
      createTest('Search all', searchesCoverAllNamedFields),
    ];
  }

  Future<void> allTracksCanBeRetrieved() async {
    var tracks = _searcher.getTracks('');

    assertEqual(_tracks, tracks);
  }

  Future<void> simpleSearch() async {
    var tracks = _searcher.getTracks('Track');
    var expected = _tracks.getRange(1, 4).toList();

    assertEqual(expected, tracks);
  }

  Future<void> searchesAreCaseInsensitive() async {
    var tracks = _searcher.getTracks('track');
    var expected = _tracks.getRange(1, 4).toList();

    assertEqual(expected, tracks);
  }

  Future<void> searchesCoverAllNamedFields() async {
    assertEqual(_tracks.getRange(0, 1).toList(), _searcher.getTracks('all'));
    assertEqual(_tracks.getRange(0, 1).toList(), _searcher.getTracks('leet'));
    assertEqual(_tracks.getRange(0, 1).toList(), _searcher.getTracks('rumen'));
  }

  // Support Code

  @override
  void setUpData() {
    super.setUpData();
    _tracks = List.empty(growable: true);
    addTrack('Allbatross', 'Fleetwood Mac', 'Instrumental Moods');
    addTrack('Track 1', 'Artist 1', 'Album 1');
    addTrack('Track 2', 'Artist 2', 'Album 2');
    addTrack('Track 3', 'Artist 3', 'Album 3');
  }

  addTrack(String trackName, String artist, String album) {
    _tracks.add(TrackInformation(
        1, trackName, '$trackName.txt', 1, album, '$album.txt', 1, artist));
  }

  @override
  void setUpObjectUnderTest() {
    _searcher = TrackSearcher(_tracks);
  }
}
