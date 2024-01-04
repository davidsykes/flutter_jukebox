import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/tools/search/searchparameters.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../tools/search/searchitem.dart';

class SearchItemTests extends TestModule {
  late ISearchItem _item;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest2(aSimpleMatch),
      createTest2(aSimpleNonMatch),
      createTest('Searches are case insensitive', searchesAreCaseInsensitive),
      createTest('Search all', searchesCoverAllNamedFields),
      createTest('Search artist', searchesCanBeNarrowedDownByArtist),
      createTest('Search artist case insensitive',
          searchesCanBeNarrowedDownByArtistCaseInsensitive),
    ];
  }

  //#region Text Searches

  Future<void> aSimpleMatch() async {
    var sp = SearchParameters(searchText: 'Track Name');

    assertTrue(_item.matches(sp));
  }

  Future<void> aSimpleNonMatch() async {
    var sp = SearchParameters(searchText: 'Track Same');

    assertFalse(_item.matches(sp));
  }

  Future<void> searchesAreCaseInsensitive() async {
    var sp = SearchParameters(searchText: 'tRACK nAME');

    assertTrue(_item.matches(sp));
  }

  Future<void> searchesCoverAllNamedFields() async {
    var sp = SearchParameters(searchText: 'track');
    assertTrue(_item.matches(sp));
    sp = SearchParameters(searchText: 'album');
    assertTrue(_item.matches(sp));
    sp = SearchParameters(searchText: 'artist');
    assertTrue(_item.matches(sp));
  }

  // end region

  // Artist searches

  Future<void> searchesCanBeNarrowedDownByArtist() async {
    var sp = SearchParameters(searchText: '', artist: 'tist');
    assertTrue(_item.matches(sp));
    sp = SearchParameters(searchText: '', artist: 'tast');
    assertFalse(_item.matches(sp));
  }

  Future<void> searchesCanBeNarrowedDownByArtistCaseInsensitive() async {
    var sp = SearchParameters(searchText: '', artist: 'TIST');
    assertTrue(_item.matches(sp));
    sp = SearchParameters(searchText: '', artist: 'TAST');
    assertFalse(_item.matches(sp));
  }

  // end region

  // Support Code

  @override
  void setUpObjectUnderTest() {
    var track = TrackInformation(123, 'Track Name', 'Track File Name', 456,
        'Album Name', 'Album Path', 789, 'Artist Name');
    _item = SearchItem(track);
  }
}
