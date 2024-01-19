class VersionDetails {
  String name;
  String jbdbApiIpAddress;
  String mp3PlayerIpAddress;
  int selectedTabOnStartUp;
  int currentlyPlayingTrackId;
  bool testAllTracks;
  VersionDetails(
      {required this.name,
      required this.jbdbApiIpAddress,
      required this.mp3PlayerIpAddress,
      required this.selectedTabOnStartUp,
      this.currentlyPlayingTrackId = 0,
      this.testAllTracks = false});
}

class Version {
  var productionVersion = VersionDetails(
      name: 'Live',
      jbdbApiIpAddress: '192.168.1.125:5003',
      mp3PlayerIpAddress: '192.168.1.125:5001',
      selectedTabOnStartUp: 0);
  var version83 = VersionDetails(
      name: '83 (local pc for db)',
      jbdbApiIpAddress: 'localhost:5051',
      mp3PlayerIpAddress: '192.168.1.126:5001',
      selectedTabOnStartUp: 4,
      currentlyPlayingTrackId: 999,
      testAllTracks: false);
  var version126 = VersionDetails(
      name: '126 (second jukebox)',
      jbdbApiIpAddress: '192.168.1.126:5003',
      mp3PlayerIpAddress: '192.168.1.126:5001',
      selectedTabOnStartUp: 4,
      testAllTracks: false);
  var versionLocal = VersionDetails(
      name: 'local',
      jbdbApiIpAddress: 'localhost:5003',
      mp3PlayerIpAddress: 'localhost:5001',
      selectedTabOnStartUp: 4,
      testAllTracks: false);

  late VersionDetails version;

  //One instance, needs factory
  static Version? _instance;
  factory Version() => _instance ??= Version._();
  Version._() {
    version = versionLocal;
  }

  String mainTitle() => 'Lynda\'s Super Jukebox (${version.name})';
}
