import 'package:flutter/material.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import 'albumlist.dart';
import 'albumpagedata.dart';

class CollectionsPage extends StatefulWidget {
  final IMicroServiceController microServiceController;
  const CollectionsPage(this.microServiceController, {super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  late AlbumPageData _albumPageData;

  @override
  void initState() {
    super.initState();

    _albumPageData = AlbumPageData(widget.microServiceController);
  }

  @override
  Widget build(BuildContext context) {
    var rows = List<Widget>.empty(growable: true);
    rows.add(const Text('Row of options'));
    rows.add(const Text('2nd Row of options'));
    rows.add(AlbumList(_albumPageData));

    return Column(
      children: rows,
    );
  }
}
