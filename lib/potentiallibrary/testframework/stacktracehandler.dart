import 'dart:convert';

class StactTraceHandler {
  late List<String> _lines;

  StactTraceHandler(String stackTrace) {
    // print('----');
    // print(stackTrace);
    // print('----');
    _lines = const LineSplitter().convert(stackTrace);
  }

  String getTestNameFromAssertStackTrace() {
    var testUnitLine = _findLineContainingTestUnit(_lines);
    var testNameLine = _windBackToLastFunctionPoint(_lines, testUnitLine);
    if (testNameLine > 0) {
      return _getTestNameFromStackTrace(_lines[testNameLine]);
    }
    return 'Test name was not found';
  }

  int _findLineContainingTestUnit(List<String> lines) {
    for (var i = 1; i < lines.length; i++) {
      if (lines[i].contains('TestUnit')) {
        return i;
      }
    }
    return 0;
  }

  int _windBackToLastFunctionPoint(List<String> lines, int line) {
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

  String getExceptionLocationFromStackTrace({int lineIndex = 0}) {
    final line = _lines[lineIndex];
    final location = _getLocationFromLine(line);
    final ignorableLocations = <String>['patch.dart', 'testframework'];
    if (ignorableLocations.any((element) => location.contains(element))) {
      return getExceptionLocationFromStackTrace(lineIndex: lineIndex + 1);
    }
    return location;
  }

  String _getLocationFromLine(String line) {
    final reg = RegExp(':(.*):[0-9]+\\)');
    final match = reg.firstMatch(line);
    if (match == null) {
      return '';
    }
    var group = match.group(1);
    if (group == null) {
      return '';
    }
    return group;
  }
}
