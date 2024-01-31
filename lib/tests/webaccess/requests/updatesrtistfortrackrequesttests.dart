import 'dart:convert';
import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../potentiallibrary/webaccess/webapirequest.dart';
import '../../../webaccess/requests/updateartistfortrackrequest.dart';

class UpdateArtistForTrackRequestTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(jsonSerialiseIsValid),
    ];
  }

  Future<void> jsonSerialiseIsValid() async {
    var request = WebApiRequest(UpdateArtistForTrackRequest(12, 34));

    var json = jsonEncode(request);

    assertEqual(
        '{"SecurityCode":123,"Request":{"TrackId":12,"ArtistId":34}}', json);
  }
}
