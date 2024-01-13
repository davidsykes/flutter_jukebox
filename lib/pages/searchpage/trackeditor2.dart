import 'package:flutter/material.dart';
import 'package:flutter_jukebox/dataobjects/artistinformation.dart';
import 'package:flutter_jukebox/dataobjects/trackinformation.dart';
import '../../potentiallibrary/widgets/futurebuilder.dart';
import '../../webaccess/servicecontroller.dart';
import 'trackeditor.dart';

class TrackEditorPageData {
  final List<ArtistInformation> artists;
  final TrackInformation track;
  TrackEditorPageData(this.artists, this.track);
}

class TrackEditorPage extends StatefulWidget {
  final IServiceController serviceController;
  final TrackInformation track;
  const TrackEditorPage(this.serviceController, this.track, {super.key});

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
}
