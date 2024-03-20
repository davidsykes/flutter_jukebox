import 'localconfiguration.dart';

abstract class ILocalConfigrationConstructor {
  LocalConfiguration constructConfiguration(String configurationText);
}

class LocalConfigrationConstructor extends ILocalConfigrationConstructor {
  @override
  LocalConfiguration constructConfiguration(String configurationText) {
    return LocalConfiguration();
  }
}
