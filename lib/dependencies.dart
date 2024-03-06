import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'package:flutter_jukebox/tools/logger.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import 'potentiallibrary/webaccess/webaccess.dart';
import 'potentiallibrary/webaccess/webapirequestcreator.dart';
import 'potentiallibrary/webaccess/webapiresponsecreator.dart';
import 'version.dart';
import 'webaccess/jukeboxdatabaseapiaccess.dart';
import 'webaccess/mp3playeraccess.dart';
import 'webaccess/trackcollectionplayer.dart';

class Dependencies {
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._() {
    var logger = Logger();
    var mp3WebAccess = WebAccess(Version().version.mp3PlayerIpAddress, logger);
    var jbdbWebAccess = WebAccess(Version().version.jbdbApiIpAddress, logger);
    var webApiRequestCreator = WebApiRequestCreator();
    var webApiResponseCreator = WebApiResponseCreator();
    var mp3WebRequestor =
        WebRequestor(mp3WebAccess, webApiRequestCreator, webApiResponseCreator);
    mp3PlayerAccess = MP3PlayerAccess(
        mp3WebRequestor, Version().version.currentlyPlayingTrackId);
    var jbdbWebRequestor = WebRequestor(
        jbdbWebAccess, webApiRequestCreator, webApiResponseCreator);
    jukeboxDatabaseApiAccess =
        JukeboxDatabaseApiAccess(jbdbWebRequestor, logger);
    var trackCollectionPlayer =
        TrackCollectionPlayer(jukeboxDatabaseApiAccess, mp3PlayerAccess);
    microServiceController = MicroServiceController(
        jukeboxDatabaseApiAccess, mp3PlayerAccess, trackCollectionPlayer);
  }

  late IMP3PlayerAccess mp3PlayerAccess;
  late IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
  late IMicroServiceController microServiceController;
}
