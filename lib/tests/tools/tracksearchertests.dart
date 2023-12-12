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
    ];
  }

  Future<void> allTracksCanBeRetrieved() async {
    var tracks = _searcher.getTracks('');

    assertEqual(_tracks, tracks);
  }

  Future<void> simpleSearch() async {
    var tracks = _searcher.getTracks('2');
    var expected = _tracks.getRange(1, 2).toList();

    assertEqual(expected, tracks);
  }

  Future<void> searchesAreCaseInsensitive() async {
    var tracks = _searcher.getTracks('HAN');
    var expected = _tracks.getRange(2, 3).toList();

    assertEqual(expected, tracks);
  }

  // Support Code

  @override
  void setUpData() {
    super.setUpData();
    var trackNames = [
      'Track 1',
      'Track 2',
      'Changes',
    ];
    _tracks = trackNames
        .map((e) =>
            TrackInformation(1, e, '$e.txt', 1, 'album', 'album', 1, 'artist'))
        .toList();
  }

  @override
  void setUpObjectUnderTest() {
    _searcher = TrackSearcher(_tracks);
  }
}
