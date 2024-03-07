import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/utilities/cachedvalue.dart';
import 'package:flutter_jukebox/potentiallibrary/widgets/futurebuilder.dart';
import '../../actions/clearcollectionaction.dart';
import '../../actions/playcollectionaction.dart';
import '../../actions/playrandomtrackaction.dart';
import '../../dataobjects/jukeboxcollection.dart';
import '../../potentiallibrary/widgets/elevatedbuttonactionwidget.dart';
import '../../webaccess/microservicecontroller.dart';

class JukeboxCollectionSelectorWidget extends StatelessWidget {
  final IMicroServiceController microServiceController;
  final CachedValue<List<JukeboxCollection>> jukeboxCollections;
  const JukeboxCollectionSelectorWidget(
      this.microServiceController, this.jukeboxCollections,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder(
        dataFetcher: dataFetcher(), pageMaker: pageMaker);
  }

  Future<List<JukeboxCollection>> dataFetcher() {
    return jukeboxCollections.getData();
  }

  Widget pageMaker(List<JukeboxCollection> collections) {
    return Row(
      children: <Widget>[
            const Text('Collections: '),
          ] +
          makeSelectCollectionButtons(collections).toList() +
          <Widget>[
            ElevatedButtonActionWidget(
                'Clear', ClearCollectionAction(microServiceController)),
            ElevatedButtonActionWidget(
                'Random', PlayRandomTrackAction(microServiceController)),
          ],
    );
  }

  List<Widget> makeSelectCollectionButtons(
      List<JukeboxCollection> collections) {
    return collections
        .map((e) => ElevatedButtonActionWidget(
            e.name, PlayCollectionAction(microServiceController, e.id)))
        .toList()
        .cast<Widget>();
  }
}
