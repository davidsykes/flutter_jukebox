import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';
import '../../tools/tracksearcher.dart';
import '../../webaccess/servicecontroller.dart';

class SearchScreenData {
  late TrackSearcher _searcher;
  SearchScreenData(List<TrackInformation> tracks) {
    _searcher = TrackSearcher(tracks);
  }

  String trackToText(TrackInformation track) {
    return track.trackName;
  }

  List<TrackInformation> getList(String searchText) {
    return _searcher.getTracks(searchText);
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

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<SearchScreenData>(
        getSearchScreenInformation, makeSearchPage);
  }

  Future<SearchScreenData> getSearchScreenInformation() async {
    var searchData = widget.serviceController.getAllTracks();
    var searchScreen = SearchScreenData(await searchData);
    return searchScreen;
  }

  Widget makeSearchPage(SearchScreenData searchScreenInformation) {
    var rows = List<Widget>.empty(growable: true);
    rows.add(makeSearchBar());
    rows.addAll(searchScreenInformation
        .getList(searchText)
        .map((track) => trackToText(track)));

    return Column(
      children: rows,
    );
  }

  Widget makeSearchBar() {
    return Row(
      children: [
        const Text('Search'),
        SizedBox(
          width: 350,
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
        )
      ],
    );
  }

  Widget trackToText(TrackInformation track) {
    return Text(track.trackName);
  }
}
