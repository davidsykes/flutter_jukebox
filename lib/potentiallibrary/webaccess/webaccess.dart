import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../tools/logger.dart';
import '../programexception.dart';

abstract class IWebAccess {
  Future<String> getTextWebData(String url);
  dynamic getJsonWebData(String url);
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
  dynamic getJsonWebData(String url) async {
    Logger().log('getJsonWebData $url');
    final httpPackageUrl = Uri.parse(makeUrl(url));
    final httpPackageInfo = await http.read(httpPackageUrl);
    final decoded = json.decode(httpPackageInfo);
    return decoded;
  }

  @override
  Future<String> getTextWebData(String url) async {
    try {
      Logger().log('getTextWebData $url');
      final httpPackageUrl = Uri.parse(makeUrl(url));
      final httpPackageInfo = await http.read(httpPackageUrl);
      Logger().log('result $httpPackageInfo');
      return httpPackageInfo;
    } on Exception catch (ex) {
      throw ProgramException('$ex.message $url');
    }
  }

  Future<String> post(String url) async {
    var result = await http.post(
      Uri.parse(makeUrl(url)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

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
