import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../tools/localconfiguration/localconfigurationconstructor.dart';
import '../../../tools/localconfiguration/localconfigurationretriever.dart';
import '../../../tools/localconfiguration/localconfigurationtextretriever.dart';

class LocalConfigurationRetrieverTests extends TestModule {
  late LocalConfigurationRetriever _retriever;
  late ILocalConfigurationTextRetriever _mockLocalConfigurationTextRetriever;
  late ILocalConfigrationConstructor _mockLocalConfigrationConstructor;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theConfigurationTextIsRetrievedAndConverted),
    ];
  }

  Future<void> theConfigurationTextIsRetrievedAndConverted() async {
    var jbapi = _retriever.retrieveLocalConfiguration();

    assertEqual('192.168.1.126:5003', jbapi.baseUri);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockLocalConfigurationTextRetriever =
        MockLocalConfigurationTextRetriever();
  }

  @override
  void setUpObjectUnderTest() {
    _retriever = LocalConfigurationRetriever(
        _mockLocalConfigurationTextRetriever,
        _mockLocalConfigrationConstructor);
  }
}

class MockLocalConfigurationTextRetriever
    extends ILocalConfigurationTextRetriever {
  @override
  String retrieveLocalConfigurationText() {
    return 'configuration text';
  }
}
