import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';
import '../../../potentiallibrary/programexception.dart';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../potentiallibrary/webaccess/webapirequestcreator.dart';
import '../../../potentiallibrary/webaccess/webapiresponsecreator.dart';
import '../../../potentiallibrary/webaccess/webrapiresponse.dart';
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
  late MockWebAccess _mockWebAccess;
  late MockWebApiRequestCreator _mockWebApiRequestCreator;
  late MockWebApiResponseCreator _mockWebApiResponseCreator;

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
      createTest(putRequestOkPassesRequestToTheWebApiRequestCreator),
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
    _mockWebAccess.response = makeSuccessfulResponse('{ "integer": 5411 }');

    var result = await _requestor.get<SimpleClassForRetrieval>(
        'url', deserialiseSimpleClassForRetrieval);
    assertEqual(5411, result.integer);
  }

  Future<void> getIfARequestReturnsAnErrorAnExceptionIsThrown() async {
    _mockWebAccess.response = makeUnsuccessfulResponse('Error Message');

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
    _mockWebAccess.response = makeSuccessfulResponse(null);

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
    _mockWebAccess.response = makeUnsuccessfulResponse('":":":":"');

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
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeSuccessfulResponse('{ "integer": 5411 }');

    var response = await _requestor.postRequestResponse(
        'url', 'Request', SimpleClassForRetrieval.fromJson);

    assertEqual(5411, response.integer);
  }

  Future<void> ifPostRequestResponseReturnsAnErrorAnExceptionIsThrown() async {
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeUnsuccessfulResponse('Error Message');

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
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeSuccessfulResponse(null);

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
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeUnsuccessfulResponse('":":":":"');

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
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeSuccessfulResponse(null);

    var result = await _requestor.postRequestOk('url', 'Request');

    assertTrue(result.success);
  }

  Future<void> ifPostRequestOkReturnsAResponseTrueIsReturned() async {
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeSuccessfulResponse('{ "integer": 5411 }');

    var result = await _requestor.postRequestOk('url', 'Request');

    assertTrue(result.success);
  }

  Future<void> ifPostRequestOkReturnsAnErrorFalseAndTheErrorIsReturned() async {
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeUnsuccessfulResponse('Error Message');

    var result = await _requestor.postRequestOk('url', 'Request');

    assertFalse(result.success);
    assertEqual('Error Message', result.error);
  }

  Future<void>
      ifPostRequestOkReturnsAMalformedResponseAnExceptionIsThrown() async {
    _mockWebAccess.expectedBody = '{"SecurityCode":123,"Request":"Request"}';
    _mockWebAccess.response = makeUnsuccessfulResponse('":":":":"');

    try {
      await _requestor.postRequestOk('url', 'Request');
    } on ProgramException catch (e) {
      assertEqual('WebApi malformed response', e.cause.substring(0, 25));
      return;
    }
    throwAssert(['Exception expected']);
  }

  Future<void> putRequestOkPassesRequestToTheWebApiRequestCreator() async {
    await _requestor.putRequestOk('url', 'putRequest');

    assertEqual('putRequest', _mockWebApiRequestCreator.request);
  }

  Future<void> putRequestOkPassesRequestToThePut() async {
    await _requestor.putRequestOk('url', 'putRequest');

    assertEqual('url', _mockWebAccess.putUrl);
    assertEqual('put web api request', _mockWebAccess.putRequest);
  }

  Future<void> putRequestOkReturnsWebApiResponse() async {
    var response = await _requestor.putRequestOk('url', 'putRequest');

    assertEqual('web api response', response);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockWebAccess = MockWebAccess();
    _mockWebApiRequestCreator = MockWebApiRequestCreator();
    _mockWebApiResponseCreator = MockWebApiResponseCreator();
  }

  @override
  void setUpObjectUnderTest() {
    _requestor = WebRequestor(
        _mockWebAccess, _mockWebApiRequestCreator, _mockWebApiResponseCreator);
  }

  SimpleClassForRetrieval deserialiseSimpleClassForRetrieval(
      Map<String, dynamic> data) {
    return SimpleClassForRetrieval.fromJson(data);
  }
}

class MockWebAccess extends IWebAccess {
  String response = '';
  String expectedBody = 'body';
  String putUrl = '';
  String putRequest = '';

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

  @override
  Future<String> putText(String url, String body) async {
    putUrl = url;
    putRequest = body;
    return url + body;
  }
}

class MockWebApiRequestCreator extends IWebApiRequestCreator {
  String? request;

  @override
  String createWebApiRequestJson(request) {
    this.request = request;
    return 'web api request$request';
  }
}

class MockWebApiResponseCreator extends IWebApiResponseCreator {
  @override
  WebApiResponse createWebApiResponse(String textResponse) {
    return WebApiResponse();
  }
}
