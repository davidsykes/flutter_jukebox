import 'package:flutter/material.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';

import 'albumlist.dart';

class CollectionsPage extends StatefulWidget {
  final IMicroServiceController microServiceController;
  const CollectionsPage(this.microServiceController, {super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  @override
  Widget build(BuildContext context) {
    var rows = List<Widget>.empty(growable: true);
    rows.add(const Text('Row of options'));
    rows.add(const Text('2nd Row of options'));
    rows.add(const AlbumList());

    return Column(
      children: rows,
    );
  }
}
