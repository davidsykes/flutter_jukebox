import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';

abstract class ILocalConfigurationTextRetriever {
  String retrieveLocalConfigurationText();
}

class LocalConfigurationTextRetriever extends ILocalConfigurationTextRetriever {
  final IWebAccess _webAccess;
  LocalConfigurationTextRetriever(this._webAccess);

  @override
  String retrieveLocalConfigurationText() {
    return 'hello wurld';
  }
}
