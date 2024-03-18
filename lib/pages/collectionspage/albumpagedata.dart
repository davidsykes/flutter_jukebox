import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import '../../dataobjects/albuminformation.dart';

class AlbumPageData {
  final IMicroServiceController _microServiceController;
  late CachedValue<List<AlbumInformation>> _albumList;

  AlbumPageData(this._microServiceController) {
    _albumList = CachedValue<List<AlbumInformation>>(fetchAlbumList);
  }

  Future<List<AlbumInformation>> getAlbumList() {
    return _albumList.getData();
  }

  Future<List<AlbumInformation>> fetchAlbumList() {
    return _microServiceController.getAllAlbums();
  }
}
