import 'package:flutter/material.dart';
import '../../dataobjects/jukeboxcollection.dart';

class JukeboxCollectionSelectorWidget extends StatelessWidget {
  final List<JukeboxCollection> jukeboxCollections;
  const JukeboxCollectionSelectorWidget(this.jukeboxCollections, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: makeSelectCollectionButtons().toList(),
    );
  }

  Iterable<Widget> makeSelectCollectionButtons() {
    var w = jukeboxCollections.map((e) => ElevatedButton(
        onPressed: () {
          onPressed(e.id);
        },
        child: Text(e.name)));
    return w.cast<Widget>();
  }

  void onPressed(int id) {
    print('pressed $id');
  }
}
