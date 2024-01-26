import '../../../potentiallibrary/testframework/testmodule.dart';
import '../../../potentiallibrary/testframework/testunit.dart';
import '../../../potentiallibrary/utilities/actionbutton.dart';

class ActionButtonTests extends TestModule {
  bool updateFunctionHasBeenCalled = false;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(theValueCanBeToggled),
      createTest(togglingTheValueCallsTheUpdateFunction),
    ];
  }

  Future<void> theValueCanBeToggled() async {
    var action = ActionButton(updateFunction);

    action.toggle();

    assertTrue(action.value);

    action.toggle();

    assertFalse(action.value);
  }

  Future<void> togglingTheValueCallsTheUpdateFunction() async {
    var action = ActionButton(updateFunction);

    action.toggle();

    assertTrue(updateFunctionHasBeenCalled);
  }

  void updateFunction() {
    updateFunctionHasBeenCalled = true;
  }
}
