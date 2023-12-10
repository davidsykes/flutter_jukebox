class VersionDetails {
  String name;
  String jbdbApiIpAddress;
  String mp3PlayerIpAddress;
  int selectedIndex;
  int currentlyPlayingTrackId;
  VersionDetails(
      {required this.name,
      required this.jbdbApiIpAddress,
      required this.mp3PlayerIpAddress,
      required this.selectedIndex,
      this.currentlyPlayingTrackId = 0});
}

class Version {
  var productionVersion = VersionDetails(
      name: 'Live',
      jbdbApiIpAddress: '192.168.1.125:5003',
      mp3PlayerIpAddress: '192.168.1.125:5001',
      selectedIndex: 0);
  var version142 = VersionDetails(
      name: '142',
      jbdbApiIpAddress: '192.168.1.142:5003',
      mp3PlayerIpAddress: '192.168.1.142:5001',
      selectedIndex: 4,
      currentlyPlayingTrackId: 999);

  late VersionDetails version;

  //One instance, needs factory
  static Version? _instance;
  factory Version() => _instance ??= Version._();
  Version._() {
    version = version142;
  }

  String mainTitle() => 'Lynda\'s Super Jukebox (${version.name})';
}