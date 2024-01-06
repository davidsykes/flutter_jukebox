import 'dart:convert';

String getTestNameFromAssertStackTrace(String stackTrace) {
  var lines = const LineSplitter().convert(stackTrace);
  for (var i = 1; i < lines.length; i++) {
    if (lines[i].contains('TestUnit')) {
      return _getTestNameFromStackTrace(lines[i - 1]);
    }
  }
  return 'Test name was not found';
}

String _getTestNameFromStackTrace(String line) {
  final reg = RegExp('#[0-9]+\\s+(\\S+)');
  final match = reg.firstMatch(line);
  final matchedText = match?.group(1);
  return matchedText ?? 'Test name was not found';
}
