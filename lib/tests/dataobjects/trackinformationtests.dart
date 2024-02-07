import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../dataobjects/trackinformation.dart';

class TrackInformationTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(gatJukeboxTrackPathAndFileName),
    ];
  }

  Future<void> gatJukeboxTrackPathAndFileName() async {
    var track = TrackInformation(1024, 'track name', 'track file name', 0,
        'albun name', 'album path', 0, 'artist');

    var jtpafn = track.getJukeboxTrackPathAndFileName();
    assertEqual(1024, jtpafn.trackId);
    assertEqual('album path', jtpafn.trackPath);
    assertEqual('track file name', jtpafn.trackFileName);
  }
}
