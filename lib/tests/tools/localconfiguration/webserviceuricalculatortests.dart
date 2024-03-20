// import '../../../potentiallibrary/testframework/testmodule.dart';
// import '../../../potentiallibrary/testframework/testunit.dart';
// import '../../../tools/webserviceuricalculator.dart';

// class WebServiceUriCalculatorTests extends TestModule {
//   final testUri = 'http://192.168.1.126:5004/';

//   late WebServiceUriCalculator _calculator;

//   @override
//   Iterable<TestUnit> getTests() {
//     return [
//       createTest(theJukeboxApiCanBeRetrieved),
//     ];
//   }

//   Future<void> theJukeboxApiCanBeRetrieved() async {
//     var jbapi = _calculator.jukeboxApi;

//     assertEqual('192.168.1.126:5003', jbapi);
//   }

//   // Support Code

//   @override
//   void setUpObjectUnderTest() {
//     _calculator = WebServiceUriCalculator(testUri);
//   }
// }
