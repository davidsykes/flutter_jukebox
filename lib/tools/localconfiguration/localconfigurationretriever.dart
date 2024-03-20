// LocalConfigurationRetriever
// 	Coordinate the classes

// LocalConfigurationTextGetter
// 	Fetch the local configuration text data, or nothing

// LocalConfigrationConstructor
// 	Convert text data into a configuration with defaults

import 'localconfiguration.dart';
import 'localconfigurationconstructor.dart';
import 'localconfigurationtextretriever.dart';

class LocalConfigurationRetriever {
  final ILocalConfigurationTextRetriever _localConfigurationTextRetriever;
  final ILocalConfigurationConstructor _localConfigrationConstructor;

  LocalConfigurationRetriever(this._localConfigurationTextRetriever,
      this._localConfigrationConstructor);

  LocalConfiguration retrieveLocalConfiguration() {
    final configurationText =
        _localConfigurationTextRetriever.retrieveLocalConfigurationText();
    final configuration =
        _localConfigrationConstructor.constructConfiguration(configurationText);
    return configuration;
  }
}
