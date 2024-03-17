import 'package:flutter/material.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';

class AlbumListPageData {}

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<AlbumListPageData>(
        dataFetcher: getAlbumListData(), pageMaker: makeAlbumListPage);
  }

  Future<AlbumListPageData> getAlbumListData() async {
    return getAlbumListData();
  }

  Widget makeAlbumListPage(AlbumListPageData pageData) {
    return Expanded(
        child: ListView(
      children: const [
        Text('Album 1'),
        Text('Album 2'),
        Text('Album 3'),
      ],
    ));
  }
}
