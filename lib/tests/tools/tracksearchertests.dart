import 'package:flutter_jukebox/dataobjects/trackinformation.dart';

import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../tools/search/searchparameters.dart';
import '../../tools/search/tracksearcher.dart';

class TrackSearcherTests extends TestModule {
  late ITrackSearcher _searcher;

  late List<TrackInformation> _tracks;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest2(tracksThatAreMatchesAreRetrieved),
    ];
  }

  //#region Text Searches

  Future<void> tracksThatAreMatchesAreRetrieved() async {
    var tracks = _searcher.getTracks(sp(''));

    assertEqual(_tracks, tracks);
  }

  //#endregion

  // Support Code

  @override
  void setUpData() {
    super.setUpData();
    _tracks = List.empty(growable: true);
    addTrack(1);
    addTrack(2);
    addTrack(3);
    addTrack(4);
    addTrack(5);
  }

  addTrack(int id) {
    _tracks.add(TrackInformation(id, 'track $id', 'track $id.txt', id,
        'album $id', 'album $id.txt', id, 'artist $id'));
  }

  @override
  void setUpObjectUnderTest() {
    _searcher = TrackSearcher(_tracks);
  }

  SearchParameters sp(String searchText) {
    return SearchParameters(searchText: searchText);
  }
}
