class VersionDetails {
  String name;
  String jbdbApiIpAddress;
  String mp3PlayerIpAddress;
  VersionDetails(
      {required this.name,
      required this.jbdbApiIpAddress,
      required this.mp3PlayerIpAddress});
}

class Version {
  var productionVersion = VersionDetails(
      name: 'Live',
      jbdbApiIpAddress: '192.168.1.125:5003',
      mp3PlayerIpAddress: '192.168.1.125:5001');
  var version142 = VersionDetails(
      name: '142',
      jbdbApiIpAddress: '192.168.1.142:5003',
      mp3PlayerIpAddress: '192.168.1.142:5001');

  late VersionDetails version;

  //One instance, needs factory
  static Version? _instance;
  factory Version() => _instance ??= Version._();
  Version._() {
    version = version142;
  }

  String mainTitle() => 'Lynda\'s Super Jukebox (${version.name})';
}
