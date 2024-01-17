class UpdateArtistForTrackRequest {
  final int trackId;
  final int artistId;
  UpdateArtistForTrackRequest(this.trackId, this.artistId);

  Map<String, dynamic> toJson() {
    return {
      'TrackId': trackId,
      'ArtistId': artistId,
    };
  }
}
