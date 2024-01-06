import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/tools/search/matchabletrack.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../tools/search/trackmatcher.dart';
import '../../tools/search/trackmatchparameters.dart';

class TrackMatcherTests extends TestModule {
  late ITrackMatcher _item;
  late MatchableTrack _track;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleMatch),
      createTest(aSimpleNonMatch),
      createTest(searchesAreCaseInsensitive),
      createTest(searchesCoverAllNamedFields),
      createTest(searchesCanBeNarrowedDownByArtist),
      createTest(searchesCanBeNarrowedDownByArtistCaseInsensitive),
    ];
  }

  //#region Text Searches

  Future<void> aSimpleMatch() async {
    var sp = TrackMatchParameters(searchText: 'Track Name');

    assertTrue(_item.matches(_track, sp));
  }

  Future<void> aSimpleNonMatch() async {
    var sp = TrackMatchParameters(searchText: 'Track Same');

    assertFalse(_item.matches(_track, sp));
  }

  Future<void> searchesAreCaseInsensitive() async {
    var sp = TrackMatchParameters(searchText: 'tRACK nAME');

    assertTrue(_item.matches(_track, sp));
  }

  Future<void> searchesCoverAllNamedFields() async {
    var sp = TrackMatchParameters(searchText: 'track');
    assertTrue(_item.matches(_track, sp));
    sp = TrackMatchParameters(searchText: 'album');
    assertTrue(_item.matches(_track, sp));
    sp = TrackMatchParameters(searchText: 'artist');
    assertTrue(_item.matches(_track, sp));
  }

  // end region

  // Artist searches

  Future<void> searchesCanBeNarrowedDownByArtist() async {
    var sp = TrackMatchParameters(searchText: '', artist: 'tist');
    assertTrue(_item.matches(_track, sp));
    sp = TrackMatchParameters(searchText: '', artist: 'tast');
    assertFalse(_item.matches(_track, sp));
  }

  Future<void> searchesCanBeNarrowedDownByArtistCaseInsensitive() async {
    var sp = TrackMatchParameters(searchText: '', artist: 'TIST');
    assertTrue(_item.matches(_track, sp));
    sp = TrackMatchParameters(searchText: '', artist: 'TAST');
    assertFalse(_item.matches(_track, sp));
  }

  // end region

  // Support Code

  @override
  void setUpData() {
    super.setUpData();
    var track = TrackInformation(123, 'Track Name', 'Track File Name', 456,
        'Album Name', 'Album Path', 789, 'Artist Name');
    _track = MatchableTrack(track);
  }

  @override
  void setUpObjectUnderTest() {
    _item = TrackMatcher();
  }
}
