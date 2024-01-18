// ignore_for_file: non_constant_identifier_names

class WebApiRequest {
  final int SecurityCode = 123;
  final dynamic Request;
  WebApiRequest(this.Request);

  Map<String, dynamic> toJson() {
    return {
      'SecurityCode': SecurityCode,
      'Request': Request,
    };
  }
}
