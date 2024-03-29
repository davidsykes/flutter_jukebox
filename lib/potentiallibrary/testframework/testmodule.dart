import 'dart:convert';
import 'testunit.dart';
import 'stacktracehandler.dart';

abstract class TestModule {
  Iterable<TestUnit> getTests();

  void setUpData() {}
  void setUpMocks() {}
  void setUpObjectUnderTest() {}

  TestUnit createTest(Future<void> Function() action) {
    return TestUnit(testModule: this, action: action);
  }

  void assertTrue(bool value) {
    if (!value) {
      throwAssert(['Expected true']);
    }
  }

  void assertFalse(bool value) {
    if (value) {
      throwAssert(['expected false']);
    }
  }

  void assertSameObject(dynamic expected, dynamic actual) {
    if (actual != expected) {
      throwAssert(['Expected identical objects']);
    }
  }

  void assertEqual(dynamic expected, dynamic actual) {
    var vj = json.encode(actual);
    var ej = json.encode(expected);
    if (vj != ej) {
      throwAssert(['Expected $ej', 'got $vj']);
    }
  }

  void assertError(String cause) {
    throwAssert([cause]);
  }

  void throwAssert(List<String> causes) {
    var st = StactTraceHandler(StackTrace.current.toString());
    var test = st.getTestNameFromAssertStackTrace();
    throw TestAssertFailException(test, causes);
  }
}

class TestAssertFailException implements Exception {
  String testName;
  List<String> causes = List.empty();
  TestAssertFailException(this.testName, this.causes);
}
