import 'package:http/http.dart' as http;
import '../../tools/logger.dart';
import '../programexception.dart';
import '../utilities/ilogger.dart';

abstract class IWebAccess {
  Future<String> get(String url);
  Future<String> post(String url, String body);
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
      Logger().log('getTextWebData $url');
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
  Future<String> post(String url, String body) async {
    var result = await http.post(Uri.parse(makeUrl(url)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (result.statusCode == 200) {
      return 'Ok';
    }
    _logger.log('Post Error ${result.statusCode}: ${result.body}');
    return 'Fail';
  }

  Future<String> put(String url, String? putBody) async {
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
