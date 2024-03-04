class WebApiRequest {
  final int securityCode = 123;
  final dynamic request;
  WebApiRequest(this.request);

  Map<String, dynamic> toJson() {
    return {
      'SecurityCode': securityCode,
      'Request': request,
    };
  }
}
