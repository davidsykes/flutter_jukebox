import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../potentiallibrary/webaccess/webapiresponsecreator.dart';

class WebApiResponseCreatorTests extends TestModule {
  late IWebApiResponseCreator _creator;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(getASimpleResponseCanBeCreated),
      createTest(getAFailedResponseCanBeCreated),
    ];
  }

  Future<void> getASimpleResponseCanBeCreated() async {
    var response =
        '{"responseType":"WebApiLibrary.WebApiOkResponse","response":{},"error":null,"success":true}';

    var apiResponse = _creator.createWebApiResponse(response);

    assertEqual(true, apiResponse.success);
    assertEqual('', apiResponse.error);
  }

  Future<void> getAFailedResponseCanBeCreated() async {
    var response =
        '{"responseType":"WebApiLibrary.WebApiOkResponse","response":{},"error":"an error","success":true}';

    var apiResponse = _creator.createWebApiResponse(response);

    assertEqual(false, apiResponse.success);
    assertEqual('an error', apiResponse.error);
  }

  // Support Code

  @override
  void setUpObjectUnderTest() {
    _creator = WebApiResponseCreator();
  }
}
