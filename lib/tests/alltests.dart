import '../potentiallibrary/testframework/testrunner.dart';
import '../potentiallibrary/testframework/testresults.dart';
import 'actions/updateartistfortrackactiontests.dart';
import 'dataobjects/trackinformationtests.dart';
import 'potentiallibrary/testframework/teststacktracehandlertests.dart';
import 'potentiallibrary/utilities/actionbuttontests.dart';
import 'potentiallibrary/webaccess/webrequestortests.dart';
import 'tools/trackmatchertests.dart';
import 'tools/listoftracksformatchingtests.dart';
import 'webaccess/jukeboxdatabaseapiaccesstests.dart';
import 'webaccess/mp3playeraccesstests.dart';
import 'webaccess/requests/updatesrtistfortrackrequesttests.dart';
import 'webaccess/microservicecontrollertests.dart';
import 'webaccess/trackcollectionplayertests.dart';

class AllTests {
  String summary = 'not run';

  Future<TestResults> runTests() async {
    var runner = TestRunner();

    runner.addTests(TestStackTraceHandlerTests());
    runner.addTests(WebRequestorTests());
    runner.addTests(MP3PlayerAccessTests());
    runner.addTests(TrackCollectionPlayerTests());
    runner.addTests(JukeboxDatabaseApiAccessTests());
    runner.addTests(MicroServiceControllerTests());
    runner.addTests(ListOfTracksForMatchingTests());
    runner.addTests(TrackMatcherTests());
    runner.addTests(UpdateArtistForTrackActionTests());
    runner.addTests(UpdateArtistForTrackRequestTests());
    runner.addTests(ActionButtonTests());
    runner.addTests(TrackInformationTests());

    var results = await runner.runTests();

    return results;
  }
}
