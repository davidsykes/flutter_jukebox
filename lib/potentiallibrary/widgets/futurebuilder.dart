import 'package:flutter/material.dart';

createFutureBuilder<T extends Object>(
    {required Future<T> dataFetcher,
    required Widget Function(T) pageMaker,
    Widget Function()? waitMessageMaker}) {
  return FutureBuilder(
    future: dataFetcher,
    builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
      List<Widget> children;
      if (snapshot.hasData) {
        return pageMaker(snapshot.data!);
      } else if (snapshot.hasError) {
        children = <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot.error}'),
          ),
        ];
      } else {
        children = <Widget>[
          const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: waitMessageMaker == null
                ? const Text('Awaiting result...')
                : waitMessageMaker(),
          ),
        ];
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      );
    },
  );
}
