import 'dart:async';
import 'dart:convert';
import 'testmodule.dart';
import 'testresults.dart';
import 'testunit.dart';

class TestRunner {
  List<TestUnit> tests = List.empty(growable: true);

  void addTests(TestModule testModule) {
    var newTests = testModule.getTests();
    tests.addAll(newTests);
  }

  Future<TestResults> runTests() async {
    var testResults = TestResults();

    for (final test in tests) {
      try {
        test.setUpData();
        test.setUpMocks();
        test.setUpObjectUnderTest();
        await test
            .runTest()
            .then((_) => aTestHasPassed(testResults))
            .catchError((error) => aTestHasFailed(test, testResults, error));
      } on TestAssertFailException catch (e) {
        var cause = e.cause;
        testResults.results.add('Fail: $cause');
        for (final extraCause in e.causes) {
          testResults.results.add(extraCause);
        }
        testResults.results.add('-------------------');
      } on Exception catch (e) {
        // Anything else that is an exception
        testResults.results.add('Unknown exception: $e');
      } catch (e, s) {
        // No specified type, handles all
        testResults.results.add('Fail: Unknown error: $e');
        testResults.results.add('$s');
        testResults.results.add('-------------------');
      }
    }

    return testResults;
  }

  aTestHasPassed(TestResults testResults) {
    testResults.numberOfTests++;
    testResults.numberOfPassingTests++;
  }

  aTestHasFailed(TestUnit test, TestResults testResults, dynamic error) {
    testResults.numberOfTests++;
    var testName = findTestName(error);
    testResults.results.add('------------ Failed: $testName --------------');

    if (error is TestAssertFailException) {
      testResults.results.add(error.causes.join(' - '));
    } else if (error is Error) {
      testResults.results.add(error.runtimeType.toString());
    } else {
      testResults.results.add(error.toString());
    }

    if (error is Error) {
      var ls = getMethodNameThatThrewTheException(error);
      testResults.results.add(ls);
    }
  }

  String getMethodNameThatThrewTheException(Error error) {
    var st = error.stackTrace.toString();
    var ls = const LineSplitter().convert(st)[0];
    return ls;
  }

  String findTestName(dynamic error) {
    if (error is Error) {
      return findTestNameFromError(error);
    } else {
      return 'The Error Type has not been recognised';
    }
  }

  String findTestNameFromError(Error error) {
    var st = error.stackTrace.toString();
    var lines = const LineSplitter().convert(st);
    for (var i = 1; i < lines.length; i++) {
      if (lines[i].contains('TestUnit')) {
        return lines[i - 1];
      }
    }
    return 'Test name was not found';
  }
}
