import 'dart:convert';

import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../webaccess/requests/updatesrtistfortrackrequest.dart';

class UpdateArtistForTrackRequestTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(jsonSerialiseIsValid),
    ];
  }

  Future<void> jsonSerialiseIsValid() async {
    var request = UpdateArtistForTrackRequest(12, 34);

    var json = jsonEncode(request);

    assertEqual('{\"TrackId\":12,\"ArtistId\":34}', json);
  }
}
