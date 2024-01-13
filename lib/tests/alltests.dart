import '../potentiallibrary/testframework/testrunner.dart';
import 'potentiallibrary/testframework/teststacktracehandlertests.dart';
import 'tools/trackmatchertests.dart';
import 'tools/listoftracksformatchingtests.dart';
import 'webaccess/jukeboxdatabaseapiaccesstests.dart';
import 'webaccess/mp3playeraccesstests.dart';
import 'potentiallibrary/webrequestortests.dart';
import 'webaccess/servicecontrollertests.dart';
import '../potentiallibrary/testframework/testresults.dart';

class AllTests {
  String summary = 'not run';

  Future<TestResults> runTests() async {
    var runner = TestRunner();

    runner.addTests(TestStackTraceHandlerTests());
    runner.addTests(WebRequestorTests());
    runner.addTests(MP3PlayerAccessTests());
    runner.addTests(JukeboxDatabaseApiAccessTests());
    runner.addTests(ServiceControllerTests());
    runner.addTests(ListOfTracksForMatchingTests());
    runner.addTests(TrackMatcherTests());

    var results = await runner.runTests();

    return results;
  }
}
