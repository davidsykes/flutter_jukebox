import 'testmodule.dart';

class TestUnit {
  final String name;
  TestModule testModule;
  Future<void> Function() action;

  TestUnit(
      {required this.name, required this.testModule, required this.action});

  void setUpData() {
    testModule.setUpData();
  }

  void setUpMocks() {
    testModule.setUpMocks();
  }

  void setUpObjectUnderTest() {
    testModule.setUpObjectUnderTest();
  }

  Future<void> runTest() async {
    await action();
  }
}
