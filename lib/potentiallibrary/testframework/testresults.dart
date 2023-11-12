class TestResults {
  int numberOfTests = 0;
  int numberOfPassingTests = 0;
  List<String> results = List.empty(growable: true);

  String get summary => getSummary();

  String getSummary() {
    int failed = numberOfTests - numberOfPassingTests;
    return ('$numberOfTests tests. $failed failed');
  }
}
