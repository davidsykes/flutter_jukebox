import 'package:flutter_jukebox/tools/ipaddresscalculator.dart';
import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';

class IpAddressCalculatorTests extends TestModule {
  late IpAddressCalculator _calculator;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(whenBaseIsHttpServersAreLocal),
      createTest(whenBaseIsFileServersUseDefault),
    ];
  }

  Future<void> whenBaseIsHttpServersAreLocal() async {
    assertTrue(false);
  }

  Future<void> whenBaseIsFileServersUseDefault() async {
    assertTrue(false);
  }
  // Support Code

  @override
  void setUpObjectUnderTest() {
    _calculator = IpAddressCalculator('dd');
  }
}
