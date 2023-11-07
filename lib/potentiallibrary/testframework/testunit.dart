import 'testmodule.dart';

class TestUnit {
  TestModule testModule;
  void Function() action;

  TestUnit({required this.testModule, required this.action});

  void setUpData() {
    testModule.setUpData();
  }

  void setUpMocks() {
    testModule.setUpMocks();
  }

  void setUpObjectUnderTest() {
    testModule.setUpObjectUnderTest();
  }

  runTest() {
    action();
  }
}
