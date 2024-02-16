import 'package:flutter/material.dart';
import '../../actions/playcollectionaction.dart';
import '../../dataobjects/jukeboxcollection.dart';
import '../../potentiallibrary/widgets/elevatedbuttonactionwidget.dart';
import '../../webaccess/microservicecontroller.dart';

class JukeboxCollectionSelectorWidget extends StatelessWidget {
  final IMicroServiceController microServiceController;
  final List<JukeboxCollection> jukeboxCollections;
  const JukeboxCollectionSelectorWidget(
      this.microServiceController, this.jukeboxCollections,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
            const Text('Collections: '),
          ] +
          makeSelectCollectionButtons().toList(),
    );
  }

  List<Widget> makeSelectCollectionButtons() {
    return jukeboxCollections
        .map((e) => ElevatedButtonActionWidget(
            e.name, PlayCollectionAction(microServiceController, e.id)))
        .toList()
        .cast<Widget>();
  }
}
