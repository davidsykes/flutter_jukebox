import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';
import '../../../potentiallibrary/programexception.dart';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../potentiallibrary/webaccess/webrequestor.dart';

class SimpleClassForRetrieval {
  final int integer;
  SimpleClassForRetrieval(this.integer);

  factory SimpleClassForRetrieval.fromJson(Map<String, dynamic> data) {
    final integer = data['integer'];
    return SimpleClassForRetrieval(integer);
  }
}

class WebRequestorTests extends TestModule {
  late IWebRequestor _requestor;
  late MockWebAccess _webAccess;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(aSimpleRequestCanBeMade),
      createTest(ifARequestReturnsAnErrorAnExceptionIsThrown),
      createTest(postPostsAndReturnsResponse),
    ];
  }

  Future<void> aSimpleRequestCanBeMade() async {
    _webAccess.response = '''{
  "responseType": "MP3PlayerDataObjects.Requests.MP3PlayerGetCurrentTrackRequest+Response",
  "response": {
    "integer": 5411
  },
  "error": null,
  "success": true
}''';

    var result = await _requestor.get<SimpleClassForRetrieval>(
        'url', deserialiseSimpleClassForRetrieval);
    assertEqual(5411, result.integer);
  }

  Future<void> ifARequestReturnsAnErrorAnExceptionIsThrown() async {
    _webAccess.response = '''{
      "responseType":"Response",
      "response":null,
      "error":"Error Message","success":false}''';
    try {
      var result = await _requestor.get<SimpleClassForRetrieval>(
          'url', deserialiseSimpleClassForRetrieval);
      assertEqual(5411, result.integer);
    } on ProgramException catch (e) {
      assertEqual('WebRequest error: Error Message', e.cause);
      return;
    }
    throwAssert(['Exception expected']);
  }

  SimpleClassForRetrieval deserialiseSimpleClassForRetrieval(
      Map<String, dynamic> data) {
    return SimpleClassForRetrieval.fromJson(data);
  }

  Future<void> postPostsAndReturnsResponse() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';

    var request = 'Request';
    var response = await _requestor.post('url', request);

    assertEqual('expected', response);
  }

  // Support Code

  @override
  void setUpMocks() {
    _webAccess = MockWebAccess();
  }

  @override
  void setUpObjectUnderTest() {
    _requestor = WebRequestor(_webAccess);
  }
}

class MockWebAccess extends IWebAccess {
  String response = '';
  String expectedBody = 'body';

  @override
  Future<String> get(String url) {
    return Future<String>.value(response);
  }

  @override
  Future<String> post(String url, String body) {
    if (url == 'url' && body == expectedBody) {
      return Future<String>.value('expected');
    }
    return Future<String>.value('invalid url \'$url\' \'$body\'');
  }
}
