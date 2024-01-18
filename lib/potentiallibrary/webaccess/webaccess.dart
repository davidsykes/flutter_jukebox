import 'package:http/http.dart' as http;
import '../../tools/logger.dart';
import '../programexception.dart';

abstract class IWebAccess {
  Future<String> getTextWebData(String url);
  Future<String> post(String url, String body);
}

class WebAccess extends IWebAccess {
  late String ipAddress;

  WebAccess(String ip) {
    ipAddress = ip;
  }

  String makeUrl(String u) {
    return 'http://$ipAddress/$u';
  }

  @override
  Future<String> getTextWebData(String url) async {
    try {
      Logger().log('getTextWebData $url');
      final fullurl = makeUrl(url);
      final httpPackageUrl = Uri.parse(fullurl);
      final httpPackageInfo = await http.read(httpPackageUrl);
      return httpPackageInfo;
    } on Exception catch (ex) {
      throw ProgramException('$ex.message $url');
    }
  }

  @override
  Future<String> post(String url, String body) async {
    var result = await http.post(Uri.parse(makeUrl(url)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    var code = result.statusCode;
    var resultBody = result.body;
    return '$code : $resultBody';
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
