import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../potentiallibrary/utilities/actionhandler.dart';

class TestAction extends ActionHandler {
  int actionValue = 0;

  @override
  Future<bool> action(int value) {
    actionValue = value;
    return Future<bool>.value(true);
  }
}

class ActionHandlerTests extends TestModule {
  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theActionCanBeActioned),
    ];
  }

  Future<void> theActionCanBeActioned() async {
    var action = TestAction();

    action.action(24);

    assertEqual(24, action.actionValue);
  }
}
