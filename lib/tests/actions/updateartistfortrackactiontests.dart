import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../actions/updateartistfortrackaction.dart';
import '../mocks/stubmicroservicecontroller.dart';

class UpdateArtistForTrackActionTests extends TestModule {
  late UpdateArtistForTrackAction _action;
  late MockMicroServiceController _mockMicroServiceController;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theArtistCanBeUpdated),
    ];
  }

  Future<void> theArtistCanBeUpdated() async {
    _action.update(27);

    assertEqual(86, _mockMicroServiceController._updatedTrack);
    assertEqual(27, _mockMicroServiceController._updatedArtist);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockMicroServiceController = MockMicroServiceController();
  }

  @override
  void setUpObjectUnderTest() {
    _action = UpdateArtistForTrackAction(_mockMicroServiceController, 86);
  }
}

class MockMicroServiceController extends StubMicroServiceController {
  int _updatedTrack = 0;
  int _updatedArtist = 0;

  @override
  Future<bool> updateArtistForTrack(int trackId, int artistId) {
    _updatedTrack = trackId;
    _updatedArtist = artistId;
    return Future(() => true);
  }
}
