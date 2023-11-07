import 'package:flutter/material.dart';

createFutureBuilder<T extends Object>(
    Future<T> Function() dataFetcher, Widget Function(T) pageMaker) {
  return FutureBuilder(
    future: dataFetcher(),
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
        children = const <Widget>[
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
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
