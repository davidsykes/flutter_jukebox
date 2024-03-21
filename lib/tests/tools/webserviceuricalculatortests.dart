import 'package:flutter_jukebox/tools/webserviceuricalculator.dart';

import '../../potentiallibrary/testframework/testmodule.dart';
import '../../potentiallibrary/testframework/testunit.dart';

class WebServiceUriCalculatorTests extends TestModule {
  late WebServiceUriCalculator _calculator;

  @override
  Iterable<TestUnit> getTests() {
    return [
      createTest(whenBaseIsHttpServersAreLocal),
      createTest(whenBaseIsFileServersUseDefault),
    ];
  }

  Future<void> whenBaseIsHttpServersAreLocal() async {
    _calculator = WebServiceUriCalculator(
        'http://192.168.1.126:5004/', 'http://192.168.1.125:5004/');

    assertEqual('http://192.168.1.126:5003/', _calculator.jbdbApiIpAddress);
    assertEqual('http://192.168.1.126:5001/', _calculator.mp3PlayerIpAddress);
  }

  Future<void> whenBaseIsFileServersUseDefault() async {
    _calculator = WebServiceUriCalculator(
        'file:///D::/whatever', 'http://192.168.1.125:5004/');

    assertEqual('http://192.168.1.125:5003/', _calculator.jbdbApiIpAddress);
    assertEqual('http://192.168.1.125:5001/', _calculator.mp3PlayerIpAddress);
  }
}
