import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import 'recentlyplayedtrackswidget.dart';

class MyWidgetFactory {
  final IMicroServiceController _microServiceController;

  MyWidgetFactory(this._microServiceController);

  RecentlyPlayedTracksWidget getRecentPlayedTracksWidget() {
    return RecentlyPlayedTracksWidget(_microServiceController);
  }
}
