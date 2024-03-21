class WebServiceUriCalculator {
  late String jbdbApiIpAddress;
  late String mp3PlayerIpAddress;

  WebServiceUriCalculator(String baseUri, String defaultUri) {
    if (baseUri.substring(0, 4) == 'http') {
      populateHttpAddresses(baseUri);
    } else {
      populateHttpAddresses(defaultUri);
    }
  }

  populateHttpAddresses(String uri) {
    final reg = RegExp('(.+):[0-9]+');
    final match = reg.firstMatch(uri);
    if (match != null) {
      var baseIp = match.group(1)!;
      jbdbApiIpAddress = '$baseIp:5003/';
      mp3PlayerIpAddress = '$baseIp:5001/';
    }
  }
}
