import '../potentiallibrary/testframework/testrunner.dart';
import 'webaccess/jukeboxdatabaseapiaccesstests.dart';
import 'webaccess/mp3playeraccesstests.dart';
import 'webaccess/webrequestortests.dart';
import 'package:flutter_jukebox/potentiallibrary/testframework/testresults.dart';

class AllTests {
  String summary = 'not run';

  Future<TestResults> runTests() async {
    var runner = TestRunner();

    runner.addTests(WebRequestorTests());
    runner.addTests(MP3PlayerAccessTests());
    runner.addTests(JukeboxDatabaseApiAccessTests());

    var results = await runner.runTests();

    return results;
  }
}
