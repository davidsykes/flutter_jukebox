import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'package:flutter_jukebox/tools/logger.dart';
import 'package:flutter_jukebox/tools/webserviceuricalculator.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import '../potentiallibrary/webaccess/webaccess.dart';
import '../potentiallibrary/webaccess/webapirequestcreator.dart';
import '../potentiallibrary/webaccess/webapiresponsecreator.dart';
import '../webaccess/jukeboxdatabaseapiaccess.dart';
import '../webaccess/mp3playeraccess.dart';
import '../webaccess/trackcollectionplayer.dart';

class Dependencies {
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._() {
    var logger = Logger();
    var ips = WebServiceUriCalculator(
        Uri.base.toString(), 'http://192.168.1.126:5004/');
    var mp3WebAccess = WebAccess(ips.mp3PlayerIpAddress, logger);
    var jbdbWebAccess = WebAccess(ips.jbdbApiIpAddress, logger);
    var webApiRequestCreator = WebApiRequestCreator();
    var webApiResponseCreator = WebApiResponseCreator();
    var mp3WebRequestor =
        WebRequestor(mp3WebAccess, webApiRequestCreator, webApiResponseCreator);
    mp3PlayerAccess = MP3PlayerAccess(mp3WebRequestor);
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
