import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/albuminformation.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';
import 'albumpagedata.dart';

class AlbumList extends StatefulWidget {
  final AlbumPageData albumPageData;
  const AlbumList(this.albumPageData, {super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<List<AlbumInformation>>(
        dataFetcher: getAlbumListData(), pageMaker: makeAlbumListPage);
  }

  Future<List<AlbumInformation>> getAlbumListData() {
    return widget.albumPageData.getAlbumList();
  }

  Widget makeAlbumListPage(List<AlbumInformation> albumList) {
    return Expanded(
        child: ListView(
      children: albumList.map((a) => makeAlbumEntry(a)).toList(),
    ));
  }

  Widget makeAlbumEntry(AlbumInformation album) {
    return Text(album.albumName);
  }
}
