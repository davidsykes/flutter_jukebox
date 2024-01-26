import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/artistinformation.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/actionbutton.dart';
import '../../actions/updateartistfortrackaction.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';
import '../../webaccess/microservicecontroller.dart';
import 'artistselector.dart';

class TrackEditorPageData {
  final List<ArtistInformation> artists;
  final TrackInformation track;
  TrackEditorPageData(this.artists, this.track);
}

class TrackEditorPage extends StatefulWidget {
  final IMicroServiceController serviceController;
  final TrackInformation track;
  final ActionButton returnToSearchPageActionButton;
  const TrackEditorPage(
      this.serviceController, this.track, this.returnToSearchPageActionButton,
      {super.key});

  @override
  State<TrackEditorPage> createState() => _TrackEditorPageState();
}

class _TrackEditorPageState extends State<TrackEditorPage> {
  @override
  Widget build(BuildContext context) {
    return createFutureBuilder<TrackEditorPageData>(
        dataFetcher: getSearchScreenInformation(), pageMaker: makeSearchPage);
  }

  Future<TrackEditorPageData> getSearchScreenInformation() async {
    var artists = widget.serviceController.getAllArtists();
    var data = TrackEditorPageData(await artists, widget.track);
    return data;
  }

  Widget makeSearchPage(TrackEditorPageData editorData) {
    return makeTrackEditor(editorData.track, editorData.artists);
  }

  Widget makeTrackEditor(
      TrackInformation track, List<ArtistInformation> artists) {
    var rows = List<Widget>.empty(growable: true);

    rows.add(Text(track.trackName));

    rows.add(makeArtistRow(track, artists));
    rows.add(TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: goBackToSearchPage,
      child: const Text('Back'),
    ));

    return Column(
      children: rows,
    );
  }

  void goBackToSearchPage() {
    widget.returnToSearchPageActionButton.toggle();
  }

  Widget makeArtistRow(
      TrackInformation track, List<ArtistInformation> artists) {
    return Row(children: [
      const SizedBox(
        width: 50,
        child: Text('Artist'),
      ),
      SizedBox(
        width: 100,
        child: Text(track.artistName),
      ),
      SizedBox(
        width: 700,
        child: ArtistSelector(
            artists,
            UpdateArtistForTrackAction(
                widget.serviceController, track.trackId)),
      ),
    ]);
  }
}
