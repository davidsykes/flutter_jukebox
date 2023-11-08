import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../potentiallibrary/webaccess/webrequestor.dart';

class WebRequestorTests extends TestModule {
  late IWebRequestor _requestor;

  @override
  void setUpObjectUnderTest() {
    _requestor = WebRequestor();
  }

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aTest),
    ];
  }

  void aTest() {
    _requestor.get('url');
    assertEqual(7, 0);
  }
}
