import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';
import '../../tools/search/trackmatcher.dart';
import '../../tools/search/trackmatchparameters.dart';
import '../../tools/search/listoftracksformatching.dart';
import '../../webaccess/servicecontroller.dart';
import 'trackeditor.dart';

class SearchScreenData {
  late IListOfTracksForMatching _matcher;
  SearchScreenData(List<TrackInformation> tracks) {
    _matcher = ListOfTracksForMatching(tracks, TrackMatcher());
  }

  String trackToText(TrackInformation track) {
    return track.trackName;
  }

  List<TrackInformation> getList(TrackMatchParameters parameters) {
    return _matcher.getTracks(parameters);
  }
}

class SearchPage extends StatefulWidget {
  final IServiceController serviceController;
  const SearchPage(this.serviceController, {super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  String artistText = '';
  String albumText = '';
  TrackInformation? _itemToEdit;

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<SearchScreenData>(
        dataFetcher: getSearchScreenInformation(), pageMaker: makeSearchPage);
  }

  Future<SearchScreenData> getSearchScreenInformation() async {
    var searchData = widget.serviceController.getAllTracks();
    var searchScreen = SearchScreenData(await searchData);
    return searchScreen;
  }

  Widget makeSearchPage(SearchScreenData searchScreenInformation) {
    if (_itemToEdit != null) {
      return TrackEditorPage(widget.serviceController, _itemToEdit!);
      //return makeTrackEditor(_itemToEdit!);
    }

    var rows = List<Widget>.empty(growable: true);
    rows.add(makeSearchBar());

    rows.add(Expanded(
        child: ListView(
      children: getMatchingTracks(searchScreenInformation)
          .map((track) => trackToText(track))
          .toList(),
    )));

    return Column(
      children: rows,
    );
  }

  List<TrackInformation> getMatchingTracks(
      SearchScreenData searchScreenInformation) {
    var parameters = TrackMatchParameters(
        searchText: searchText, artist: artistText, album: albumText);
    return searchScreenInformation.getList(parameters);
  }

  Widget makeSearchBar() {
    return Row(
      children: [
        const Text('Search'),
        SizedBox(
          width: 250,
          child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (text) {
                setState(() {
                  searchText = text;
                });
              }),
        ),
        const Text('Artist'),
        SizedBox(
          width: 250,
          child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (text) {
                setState(() {
                  artistText = text;
                });
              }),
        ),
        const Text('Album'),
        SizedBox(
          width: 250,
          child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (text) {
                setState(() {
                  albumText = text;
                });
              }),
        ),
      ],
    );
  }

  Widget trackToText(TrackInformation track) {
    var t = track.trackName;
    var artist = track.artistName;
    var album = track.albumName;
    return GestureDetector(
        child: Text('$t - $artist - $album'),
        onTap: () {
          setState(() {
            _itemToEdit = track;
          });
        });
  }
}
