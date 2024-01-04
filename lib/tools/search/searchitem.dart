import 'package:flutter_jukebox/tools/search/searchparameters.dart';

import '../../dataobjects/trackinformation.dart';

abstract class ISearchItem {
  bool matches(SearchParameters sp);
}

class SearchItem extends ISearchItem {
  late String searchText;
  TrackInformation track;
  SearchItem(this.track) {
    searchText = 'ss';
  }

  @override
  bool matches(SearchParameters sp) {
    // TODO: implement matches
    throw UnimplementedError();
  }
}

// TODO: create search text, artist, album, track all lower case