class TrackMatchParameters {
  late String searchText;
  late String? artist;
  late String? album;
  TrackMatchParameters(
      {required String searchText, String? artist, String? album}) {
    this.searchText = searchText.toLowerCase();
    this.artist = artist?.toLowerCase();
    this.album = album?.toLowerCase();
  }
}
