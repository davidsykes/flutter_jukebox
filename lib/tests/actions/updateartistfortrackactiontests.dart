import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../actions/updateartistfortrackaction.dart';
import '../mocks/mockmicroservicecontroller.dart';

class UpdateArtistForTrackActionTests extends TestModule {
  late UpdateArtistForTrackAction _action;
  late MockMicroServiceController _mockMicroServiceController;
  int _updatedTrack = 0;
  int _updatedArtist = 0;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theArtistCanBeUpdated),
    ];
  }

  Future<void> theArtistCanBeUpdated() async {
    _action.action(27);

    assertEqual(86, _updatedTrack);
    assertEqual(27, _updatedArtist);
  }

  // Support Code

  @override
  void setUpMocks() {
    _mockMicroServiceController = MockMicroServiceController();
    _mockMicroServiceController.mockUpdateArtistForTrack = updateArtist;
  }

  Future<bool> updateArtist(int trackId, int artistId) async {
    _updatedTrack = trackId;
    _updatedArtist = artistId;
    return Future<bool>.value(true);
  }

  @override
  void setUpObjectUnderTest() {
    _action = UpdateArtistForTrackAction(_mockMicroServiceController, 86);
  }
}
