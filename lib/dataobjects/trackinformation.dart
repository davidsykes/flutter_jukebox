class TrackInformation {
  final int trackId;
  final String trackName;
  final String trackFileName;
  final int albumId;
  final String albumName;
  final String albumPath;
  final int artistId;
  final String artistName;
  TrackInformation(
      this.trackId,
      this.trackName,
      this.trackFileName,
      this.albumId,
      this.albumName,
      this.albumPath,
      this.artistId,
      this.artistName);

  Map<String, dynamic> toJson() {
    return {
      'trackId': trackId,
      'trackName': trackName,
      'trackFileName': trackFileName,
      'albumId': albumId,
      'albumName': albumName,
      'albumPath': albumPath,
      'artistId': artistId,
      'artistName': artistName,
    };
  }
}
