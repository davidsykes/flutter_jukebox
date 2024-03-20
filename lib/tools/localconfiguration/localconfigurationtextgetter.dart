import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';

abstract class ILocalConfigurationTextGetter {}

class LocalConfigurationTextGetter extends ILocalConfigurationTextGetter {
  final IWebAccess _webAccess;

  LocalConfigurationTextGetter(this._webAccess);

  // LocalConfiguration generateLocalConfiguration() {
  //   var config = _webAccess.get('localconfiguration de bi');

  //   return LocalConfiguration();
  // }
}
