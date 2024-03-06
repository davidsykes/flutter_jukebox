import '../../../potentiallibrary/testframework/stacktracehandler.dart';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';

class StackTraceHandlerTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theTestNameCanBeRetrieved),
      createTest(testNameCanBeMissing),
      createTest(asyncronousSuspensionsAreIgnored),
      createTest(theExceptionLocationCanBeRetrieved),
      createTest(dartLocationsAreExcludedFromTheExceptionLocation),
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

    var st = StactTraceHandler(stack);
    var testName = st.getTestNameFromAssertStackTrace();
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

    var st = StactTraceHandler(stack);
    var testName = st.getTestNameFromAssertStackTrace();
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

    var st = StactTraceHandler(stack);
    var testName = st.getTestNameFromAssertStackTrace();
    assertEqual('TestStactTraceHandlerTests.asyncronousSuspensionsAreIgnored',
        testName);
  }

  Future<void> theExceptionLocationCanBeRetrieved() async {
    var stack = """
#0      MockWebApiRequestCreator.createWebApiRequestJson (package:flutter_jukebox/tests/potentiallibrary/webaccess/webrequestortests.dart:282:5)
#1      WebRequestor.putRequestOk (package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart:89:44)
#2      WebRequestorTests.putRequestOkPassesRequestToTheWebApiRequestCreator (package:flutter_jukebox/tests/potentiallibrary/webaccess/webrequestortests.dart:209:22)
#3      TestUnit.runTest (package:flutter_jukebox/potentiallibrary/testframework/testunit.dart:22:17)
#4      TestRunner.runTests (package:flutter_jukebox/potentiallibrary/testframework/testrunner.dart:25:14)
<asynchronous suspension>
#5      AllTests.runTests (package:flutter_jukebox/tests/alltests.dart:37:19)
<asynchronous suspension>
#6      _FutureBuilderState._subscribe.<anonymous closure> (package:flutter/src/widgets/async.dart:624:31)
<asynchronous suspension>""";

    var st = StactTraceHandler(stack);
    var location = st.getExceptionLocationFromStackTrace();
    assertEqual('webrequestortests.dart:282', location);
  }

  Future<void> dartLocationsAreExcludedFromTheExceptionLocation() async {
    var stack = """
#0      Object.noSuchMethod (dart:core-patch/object_patch.dart:38:5)
#1      JukeboxDatabaseApiAccessTests.aTrackCanBeUnDeleted (package:flutter_jukebox/tests/webaccess/jukeboxdatabaseapiaccesstests.dart:110:48)
<asynchronous suspension>
#2      TestUnit.runTest (package:flutter_jukebox/potentiallibrary/testframework/testunit.dart:22:5)
<asynchronous suspension>
#3      TestRunner.runTests.<anonymous closure> (package:flutter_jukebox/potentiallibrary/testframework/testrunner.dart:26:19)
<asynchronous suspension>
#4      TestRunner.runTests (package:flutter_jukebox/potentiallibrary/testframework/testrunner.dart:24:9)
<asynchronous suspension>
#5      AllTests.runTests (package:flutter_jukebox/tests/alltests.dart:37:19)
<asynchronous suspension>
#6      _FutureBuilderState._subscribe.<anonymous closure> (package:flutter/src/widgets/async.dart:624:31)
<asynchronous suspension>""";

    var st = StactTraceHandler(stack);
    var location = st.getExceptionLocationFromStackTrace();
    assertEqual('jukeboxdatabaseapiaccesstests.dart:110', location);
  }
}
