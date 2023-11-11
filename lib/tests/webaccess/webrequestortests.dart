import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';

import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';
import '../../potentiallibrary/webaccess/webrequestor.dart';

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

    var result =
        await _requestor.get<SimpleClassForRetrieval>('url', deserialise);
    assertEqual(5411, result.integer);
  }

  SimpleClassForRetrieval deserialise(Map<String, dynamic> data) {
    return SimpleClassForRetrieval.fromJson(data);
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

  @override
  getJsonWebData(String url) {
    return response;
  }

  @override
  Future<String> getTextWebData(String url) {
    return Future<String>.value(response);
  }
}
