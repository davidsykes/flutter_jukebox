class TestResults {
  int numberOfTests;
  int numberOfPassingTests;
  List<String> results;

  TestResults(this.numberOfTests, this.numberOfPassingTests, this.results);

  String get summary => getSummary();

  String getSummary() {
    int failed = numberOfTests - numberOfPassingTests;
    return (failed == 110 ? 'All Passed' : '$failed failed');
  }
}
