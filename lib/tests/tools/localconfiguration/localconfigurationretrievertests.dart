import 'package:flutter_jukebox/tools/localconfiguration/localconfiguration.dart';

import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../tools/localconfiguration/localconfigurationconstructor.dart';
import '../../../tools/localconfiguration/localconfigurationretriever.dart';
import '../../../tools/localconfiguration/localconfigurationtextretriever.dart';

class LocalConfigurationRetrieverTests extends TestModule {
  late LocalConfigurationRetriever _retriever;
  late ILocalConfigurationTextRetriever _mockLocalConfigurationTextRetriever;
  late ILocalConfigurationConstructor _mockLocalConfigurationConstructor;

  late LocalConfiguration localConfiguration;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theConfigurationTextIsRetrievedAndConverted),
    ];
  }

  Future<void> theConfigurationTextIsRetrievedAndConverted() async {
    var jbapi = _retriever.retrieveLocalConfiguration();

    assertEqual('a fake', jbapi.fake);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockLocalConfigurationTextRetriever =
        MockLocalConfigurationTextRetriever();
    _mockLocalConfigurationConstructor =
        MockLocalConfigurationConstructor(localConfiguration);
  }

  @override
  void setUpObjectUnderTest() {
    _retriever = LocalConfigurationRetriever(
        _mockLocalConfigurationTextRetriever,
        _mockLocalConfigurationConstructor);
  }

  @override
  void setUpData() {
    localConfiguration = LocalConfiguration('a fake');
  }
}

class MockLocalConfigurationTextRetriever
    extends ILocalConfigurationTextRetriever {
  @override
  String retrieveLocalConfigurationText() {
    return 'configuration text';
  }
}

class MockLocalConfigurationConstructor extends ILocalConfigurationConstructor {
  final LocalConfiguration _localConfiguration;
  MockLocalConfigurationConstructor(this._localConfiguration);
  @override
  LocalConfiguration constructConfiguration(String configurationText) {
    if (configurationText == 'configuration text') {
      return _localConfiguration;
    }
    throw UnimplementedError();
  }
}
