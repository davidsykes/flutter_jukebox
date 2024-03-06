import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../potentiallibrary/webaccess/webapirequestcreator.dart';

class WebApiRequestCreatorTests extends TestModule {
  late IWebApiRequestCreator _creator;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(getASimpleRequestCanBeCreated),
    ];
  }

  Future<void> getASimpleRequestCanBeCreated() async {
    var request = "A request";

    var apiRequest = _creator.createWebApiRequestJson(request);

    assertEqual('{"SecurityCode":123,"Request":"A request"}', apiRequest);
  }

  // Support Code

  @override
  void setUpObjectUnderTest() {
    _creator = WebApiRequestCreator();
  }
}
