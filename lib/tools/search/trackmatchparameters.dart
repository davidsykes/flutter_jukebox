class TrackMatchParameters {
  late String searchText;
  late String? artist;
  TrackMatchParameters({required String searchText, String? artist}) {
    this.searchText = searchText.toLowerCase();
    this.artist = artist?.toLowerCase();
  }
}
