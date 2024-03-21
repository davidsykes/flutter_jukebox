import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../tools/search/matchabletrack.dart';
import '../../../tools/search/trackmatcher.dart';
import '../../../tools/search/trackmatchparameters.dart';
import '../../../tools/search/listoftracksformatching.dart';

class ListOfTracksForMatchingTests extends TestModule {
  late IListOfTracksForMatching _matcher;

  late List<TrackInformation> _tracks;
  late List<TrackInformation> _oddTracks;
  late TrackMatchParameters _parameters;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(tracksThatAreMatchesAreRetrieved),
    ];
  }

  //#region Text Searches

  Future<void> tracksThatAreMatchesAreRetrieved() async {
    var tracks = _matcher.getTracks(_parameters);

    assertEqual(_oddTracks, tracks);
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
    _oddTracks = List.empty(growable: true);
    _oddTracks.add(_tracks[0]);
    _oddTracks.add(_tracks[2]);
    _oddTracks.add(_tracks[4]);
    _parameters = TrackMatchParameters(searchText: 'searchText');
  }

  addTrack(int id) {
    _tracks.add(TrackInformation(id, 'track $id', 'track $id.txt', id,
        'album $id', 'album $id.txt', id, 'artist $id'));
  }

  @override
  void setUpObjectUnderTest() {
    _matcher = ListOfTracksForMatching(_tracks, MockTrackMatcher());
  }
}

class MockTrackMatcher extends ITrackMatcher {
  @override
  bool matches(MatchableTrack track, TrackMatchParameters sp) {
    return track.track.trackId.isOdd;
  }
}
