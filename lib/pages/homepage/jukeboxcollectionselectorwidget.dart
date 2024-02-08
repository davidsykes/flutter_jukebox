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
      children: makeSelectCollectionButtons().toList(),
    );
  }

  Iterable<Widget> makeSelectCollectionButtons() {
    var w = jukeboxCollections.map((e) => ElevatedButtonActionWidget(
        e.name, PlayCollectionAction(microServiceController, e.id)));

    return w.cast<Widget>();
  }
}
