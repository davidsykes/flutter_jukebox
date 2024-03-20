// class WebServiceUriCalculator {
//   final String baseUri;
//   late String baseIp;
//   late String jukeboxApi;

//   WebServiceUriCalculator(this.baseUri) {
//     //final baseUri = Uri.base.toString();
//     final reg = RegExp('([0-9\.]+)');
//     final match = reg.firstMatch(baseUri);
//     if (match == null) {
//       jukeboxApi = baseUri;
//     } else {
//       baseIp = match.group(1)!;
//       jukeboxApi = '$baseIp:5003';
//     }
//   }
// }
