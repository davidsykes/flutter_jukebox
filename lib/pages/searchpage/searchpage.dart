import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';
import '../../webaccess/servicecontroller.dart';

class SearchScreenData {
  SearchScreenData(List<TrackInformation> list);
}

class SearchPage extends StatefulWidget {
  final IServiceController serviceController;
  const SearchPage(this.serviceController, {super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    rows.add(const Text('sfsdff'));
    rows.add(const Text('asfsaf'));

    return Column(
      children: rows,
    );
  }
}
