import 'package:http/http.dart' as http;
import '../../tools/logger.dart';
import '../programexception.dart';
import '../utilities/ilogger.dart';

abstract class IWebAccess {
  Future<String> get(String url);
  Future<String> postText(String url, String body);
  Future<String> putText(String url, String body);
}

class WebAccess extends IWebAccess {
  final String ipAddress;
  final ILogger _logger;

  WebAccess(this.ipAddress, this._logger);

  String makeUrl(String u) {
    return 'http://$ipAddress/$u';
  }

  @override
  Future<String> get(String url) async {
    try {
      final fullurl = makeUrl(url);
      final httpPackageUrl = Uri.parse(fullurl);
      final httpPackageInfo = await http.read(httpPackageUrl);
      return httpPackageInfo;
    } on Exception catch (ex) {
      var m = ex.toString();
      _logger.log('WebAccess get exception $m');
      throw ProgramException('WebAccess get exception $m');
    }
  }

  @override
  Future<String> postText(String url, String body) async {
    final fullurl = makeUrl(url);
    Logger().log('post $fullurl');
    try {
      var result = await http.post(Uri.parse(fullurl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      Logger().log('post returned ${result.statusCode}: ${result.body}');

      if (result.statusCode == 200) {
        return result.body;
      }
      _logger.log('Post Error ${result.statusCode}: ${result.reasonPhrase}');
      return 'Fail';
    } on Exception catch (ex) {
      var m = ex.toString();
      _logger.log('WebAccess post exception $m');
      throw ProgramException('WebAccess post exception $m');
    }
  }

  @override
  Future<String> putText(String url, String body) async {
    final fullurl = makeUrl(url);
    Logger().log('put $fullurl');
    try {
      var result = await http.put(Uri.parse(fullurl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      Logger().log('put returned ${result.statusCode}: ${result.body}');

      if (result.statusCode == 200) {
        return result.body;
      }
      _logger.log('Put Error ${result.statusCode}: ${result.reasonPhrase}');
      return 'Fail';
    } on Exception catch (ex) {
      var m = ex.toString();
      _logger.log('WebAccess put exception $m');
      throw ProgramException('WebAccess put exception $m');
    }
  }

  Future<String> put999(String url, String? putBody) async {
    var result = await http.put(
      Uri.parse(makeUrl(url)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: putBody,
    );

    var code = result.statusCode;
    var resultBody = result.body;
    return '$code : $resultBody';
  }
}
