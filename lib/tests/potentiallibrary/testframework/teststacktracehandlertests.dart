import '../../../potentiallibrary/testframework/stacktracehandler.dart';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';

class TestStackTraceHandlerTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theTestNameCanBeRetrieved),
      createTest(testNameCanBeMissing),
      createTest(asyncronousSuspensionsAreIgnored),
    ];
  }

  Future<void> theTestNameCanBeRetrieved() async {
    var stack = """
#0      TestModule.throwAssert (package:flutter_jukebox/potentiallibrary/testframework/testmodule.dart:48:25)
#1      TestModule.assertFalse (package:flutter_jukebox/potentiallibrary/testframework/testmodule.dart:29:7)
#2      TestStactTraceHandlerTests.theTestNameCanBeRetrieved (package:flutter_jukebox/tests/tools/searchitemtests.dart:67:5)
#3      TestUnit.runTest (package:flutter_jukebox/potentiallibrary/testframework/testunit.dart:24:17)
#4      TestRunner.runTests (package:flutter_jukebox/potentiallibrary/testframework/testrunner.dart:24:14)
<asynchronous suspension>
#5      AllTests.runTests (package:flutter_jukebox/tests/alltests.dart:25:19)
<asynchronous suspension>
#6      _FutureBuilderState._subscribe.<anonymous closure> (package:flutter/src/widgets/async.dart:624:31)""";

    var testName = getTestNameFromAssertStackTrace(stack);
    assertEqual(
        'TestStactTraceHandlerTests.theTestNameCanBeRetrieved', testName);
  }

  Future<void> testNameCanBeMissing() async {
    var stack = """
#0      TestModule.throwAssert (package:flutter_jukebox/potentiallibrary/testframework/testmodule.dart:48:25)
#1      TestModule.assertFalse (package:flutter_jukebox/potentiallibrary/testframework/testmodule.dart:29:7)
#2
#3      TestUnit.runTest (package:flutter_jukebox/potentiallibrary/testframework/testunit.dart:24:17)
#4      TestRunner.runTests (package:flutter_jukebox/potentiallibrary/testframework/testrunner.dart:24:14)
<asynchronous suspension>
#5      AllTests.runTests (package:flutter_jukebox/tests/alltests.dart:25:19)
<asynchronous suspension>
#6      _FutureBuilderState._subscribe.<anonymous closure> (package:flutter/src/widgets/async.dart:624:31)""";

    var testName = getTestNameFromAssertStackTrace(stack);
    assertEqual('Test name was not found', testName);
  }

  Future<void> asyncronousSuspensionsAreIgnored() async {
    var stack = """
#0      TestModule.throwAssert (package:flutter_jukebox/potentiallibrary/testframework/testmodule.dart:48:25)
#1      TestModule.assertFalse (package:flutter_jukebox/potentiallibrary/testframework/testmodule.dart:29:7)
#2      TestStactTraceHandlerTests.asyncronousSuspensionsAreIgnored (package:flutter_jukebox/tests/tools/searchitemtests.dart:67:5)
some added stack information
#3      TestUnit.runTest (package:flutter_jukebox/potentiallibrary/testframework/testunit.dart:24:17)
#4      TestRunner.runTests (package:flutter_jukebox/potentiallibrary/testframework/testrunner.dart:24:14)
<asynchronous suspension>
#5      AllTests.runTests (package:flutter_jukebox/tests/alltests.dart:25:19)
<asynchronous suspension>
#6      _FutureBuilderState._subscribe.<anonymous closure> (package:flutter/src/widgets/async.dart:624:31)""";

    var testName = getTestNameFromAssertStackTrace(stack);
    assertEqual('TestStactTraceHandlerTests.asyncronousSuspensionsAreIgnored',
        testName);
  }
}
