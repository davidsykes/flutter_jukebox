import 'package:flutter/material.dart';
import 'package:flutter_jukebox/potentiallibrary/widgets/jbelevatedbutton.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import '../dataobjects/jukeboxtrackpathandsilename.dart';

class Mp3TrackPlayerWidget extends StatefulWidget {
  final JukeboxTrackPathAndFileName track;
  final IMicroServiceController serviceController;

  const Mp3TrackPlayerWidget(this.track, this.serviceController, {super.key});

  @override
  State<Mp3TrackPlayerWidget> createState() => _Mp3TrackPlayerWidgetState();
}

class _Mp3TrackPlayerWidgetState extends State<Mp3TrackPlayerWidget> {
  int state = 0;

  @override
  Widget build(Object context) {
    var colour = switch (state) {
      0 => Colors.green,
      1 => Colors.amber,
      _ => Colors.red
    };

    return JbElevatedButton('Play', colour, () async {
      setState(() {
        state = 1;
      });
      var result = await widget.serviceController.playMp3(widget.track);
      setState(() {
        state = result ? 0 : 2;
      });
    });
  }
}
