import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../actions/updateartistfortrackaction.dart';
import '../mocks/mockservicecontroller.dart';

class UpdateArtistForTrackActionTests extends TestModule {
  late UpdateArtistForTrackAction _action;
  late MockServiceController _mockServiceController;
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
    _mockServiceController = MockServiceController();
    _mockServiceController.mockUpdateArtistForTrack = updateArtist;
  }

  void updateArtist(int trackId, int artistId) {
    _updatedTrack = trackId;
    _updatedArtist = artistId;
  }

  @override
  void setUpObjectUnderTest() {
    _action = UpdateArtistForTrackAction(_mockServiceController, 86);
  }
}
