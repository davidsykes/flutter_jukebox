import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';
import 'package:flutter_jukebox/tools/localconfiguration/localconfigurationconstructor.dart';
import 'package:flutter_jukebox/tools/localconfiguration/localconfigurationretriever.dart';
import 'package:flutter_jukebox/tools/localconfiguration/localconfigurationtextretriever.dart';

import '../tools/localconfiguration/localconfiguration.dart';
import '../tools/logger.dart';

class LocalConfigurationDependencies {
  LocalConfiguration getLocalConfiguration(Logger logger) {
    var baseUri = Uri.base.toString();
    late IWebAccess localWebAccess;
    if (baseUri.substring(0, 4) == 'file') {
      //localWebAccess = FileWebAccess();
      localWebAccess = WebAccess('http://192.168.1.126:5004/', logger);
    } else {
      localWebAccess = WebAccess(baseUri, logger);
    }
    var localConfigurationTextRetriever =
        LocalConfigurationTextRetriever(localWebAccess);
    var localConfigrationConstructor = LocalConfigrationConstructor();
    var configurationRetriever = LocalConfigurationRetriever(
        localConfigurationTextRetriever, localConfigrationConstructor);
    var configuration = configurationRetriever.retrieveLocalConfiguration();
    return configuration;
  }
}

class FileWebAccess extends IWebAccess {
  @override
  Future<String> get(String url) async {
    if (url == 'localconfiguration') {
      return 'Something';
    }
    throw UnimplementedError();
  }

  @override
  Future<String> postText(String url, String body) {
    throw UnimplementedError();
  }

  @override
  Future<String> putText(String url, String body) {
    throw UnimplementedError();
  }
}
