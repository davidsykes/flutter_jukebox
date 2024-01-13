import 'dart:convert';

String getTestNameFromAssertStackTrace(String stackTrace) {
  var lines = const LineSplitter().convert(stackTrace);
  var testUnitLine = findLineContainingTestUnit(lines);
  var testNameLine = windBackToLastFunctionPoint(lines, testUnitLine);
  if (testNameLine > 0) {
    return _getTestNameFromStackTrace(lines[testNameLine]);
  }
  return 'Test name was not found';
}

int findLineContainingTestUnit(List<String> lines) {
  for (var i = 1; i < lines.length; i++) {
    if (lines[i].contains('TestUnit')) {
      return i;
    }
  }
  return 0;
}

int windBackToLastFunctionPoint(List<String> lines, int line) {
  do {
    line = line - 1;
  } while (line > 0 && lines[line][0] != '#');
  return line;
}

String _getTestNameFromStackTrace(String line) {
  final reg = RegExp('#[0-9]+\\s+(\\S+)');
  final match = reg.firstMatch(line);
  final matchedText = match?.group(1);
  return matchedText ?? 'Test name was not found';
}
