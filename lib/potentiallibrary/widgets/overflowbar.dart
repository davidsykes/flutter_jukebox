import 'package:flutter/material.dart';

abstract class IMyOverflowBar {
  List<Widget> getChildren();
}

Widget createOverflowBar(IMyOverflowBar overflowBar) {
  return (OverflowBar(
      alignment: MainAxisAlignment.start, children: overflowBar.getChildren()));
}
