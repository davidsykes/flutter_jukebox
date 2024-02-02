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
      createTest(getASimpleRequestCanBeMade),
      createTest(getIfARequestReturnsAnErrorAnExceptionIsThrown),
      createTest(getIfARequestReturnsNoResponseAnExceptionIsThrown),
      createTest(getIfARequestReturnsAMalformedResponseAnExceptionIsThrown),
      createTest(postRequestResponsePostsAndReturnsResponse),
      createTest(ifPostRequestResponseReturnsAnErrorAnExceptionIsThrown),
      createTest(ifPostRequestResponseReturnsNoResponseAnExceptionIsThrown),
      createTest(
          ifPostRequestResponseReturnsAMalformedResponseAnExceptionIsThrown),
      createTest(postRequestOkPostsAndReturnsTrue),
      createTest(ifPostRequestOkReturnsAResponseTrueIsReturned),
      createTest(ifPostRequestOkReturnsAnErrorFalseAndTheErrorIsReturned),
      createTest(ifPostRequestOkReturnsAMalformedResponseAnExceptionIsThrown),
    ];
  }

  String makeSuccessfulResponse(String? response) {
    return '''{
  "responseType": "Response Type",
  "response": $response,
  "error": null,
  "success": true
}''';
  }

  String makeUnsuccessfulResponse(String error) {
    return '''{
  "responseType": "Response Type",
  "response":null,
  "error": "$error",
  "success": false
}''';
  }

  Future<void> getASimpleRequestCanBeMade() async {
    _webAccess.response = makeSuccessfulResponse('{ "integer": 5411 }');

    var result = await _requestor.get<SimpleClassForRetrieval>(
        'url', deserialiseSimpleClassForRetrieval);
    assertEqual(5411, result.integer);
  }

  Future<void> getIfARequestReturnsAnErrorAnExceptionIsThrown() async {
    _webAccess.response = makeUnsuccessfulResponse('Error Message');

    try {
      await _requestor.get<SimpleClassForRetrieval>(
          'url', deserialiseSimpleClassForRetrieval);
    } on ProgramException catch (e) {
      assertEqual('WebRequest error: Error Message', e.cause);
      return;
    }
    throwAssert(['Exception expected']);
  }

  Future<void> getIfARequestReturnsNoResponseAnExceptionIsThrown() async {
    _webAccess.response = makeSuccessfulResponse(null);

    try {
      await _requestor.get<SimpleClassForRetrieval>(
          'url', deserialiseSimpleClassForRetrieval);
    } on ProgramException catch (e) {
      assertEqual('WebApi missing response.', e.cause.substring(0, 24));
      return;
    }
    throwAssert(['Exception expected']);
  }

  Future<void>
      getIfARequestReturnsAMalformedResponseAnExceptionIsThrown() async {
    _webAccess.response = makeUnsuccessfulResponse('":":":":"');

    try {
      await _requestor.get<SimpleClassForRetrieval>(
          'url', deserialiseSimpleClassForRetrieval);
    } on ProgramException catch (e) {
      assertEqual('WebApi malformed response', e.cause.substring(0, 25));
      return;
    }
    throwAssert(['Exception expected']);
  }

  Future<void> postRequestResponsePostsAndReturnsResponse() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeSuccessfulResponse('{ "integer": 5411 }');

    var response = await _requestor.postRequestResponse(
        'url', 'Request', SimpleClassForRetrieval.fromJson);

    assertEqual(5411, response.integer);
  }

  Future<void> ifPostRequestResponseReturnsAnErrorAnExceptionIsThrown() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeUnsuccessfulResponse('Error Message');

    try {
      await _requestor.postRequestResponse(
          'url', 'Request', SimpleClassForRetrieval.fromJson);
    } on ProgramException catch (e) {
      assertEqual('WebRequest error: Error Message', e.cause);
      return;
    }
    throwAssert(['Exception expected']);
  }

  Future<void>
      ifPostRequestResponseReturnsNoResponseAnExceptionIsThrown() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeSuccessfulResponse(null);

    try {
      await _requestor.postRequestResponse(
          'url', 'Request', SimpleClassForRetrieval.fromJson);
    } on ProgramException catch (e) {
      assertEqual('WebApi missing response.', e.cause.substring(0, 24));
      return;
    }
    throwAssert(['Exception expected']);
  }

  Future<void>
      ifPostRequestResponseReturnsAMalformedResponseAnExceptionIsThrown() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeUnsuccessfulResponse('":":":":"');

    try {
      await _requestor.postRequestResponse(
          'url', 'Request', SimpleClassForRetrieval.fromJson);
    } on ProgramException catch (e) {
      assertEqual('WebApi malformed response', e.cause.substring(0, 25));
      return;
    }
    throwAssert(['Exception expected']);
  }

  Future<void> postRequestOkPostsAndReturnsTrue() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeSuccessfulResponse(null);

    var result = await _requestor.postRequestOk('url', 'Request');

    assertTrue(result.success);
  }

  Future<void> ifPostRequestOkReturnsAResponseTrueIsReturned() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeSuccessfulResponse('{ "integer": 5411 }');

    var result = await _requestor.postRequestOk('url', 'Request');

    assertTrue(result.success);
  }

  Future<void> ifPostRequestOkReturnsAnErrorFalseAndTheErrorIsReturned() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeUnsuccessfulResponse('Error Message');

    var result = await _requestor.postRequestOk('url', 'Request');

    assertFalse(result.success);
    assertEqual('Error Message', result.error);
  }

  Future<void>
      ifPostRequestOkReturnsAMalformedResponseAnExceptionIsThrown() async {
    _webAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _webAccess.response = makeUnsuccessfulResponse('":":":":"');

    try {
      await _requestor.postRequestOk('url', 'Request');
    } on ProgramException catch (e) {
      assertEqual('WebApi malformed response', e.cause.substring(0, 25));
      return;
    }
    throwAssert(['Exception expected']);
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

  SimpleClassForRetrieval deserialiseSimpleClassForRetrieval(
      Map<String, dynamic> data) {
    return SimpleClassForRetrieval.fromJson(data);
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
  Future<String> postText(String url, String body) {
    if (url == 'url' && body == expectedBody) {
      return Future<String>.value(response);
    }
    throw ('invalid url \'$url\' \'$body\'');
  }
}
