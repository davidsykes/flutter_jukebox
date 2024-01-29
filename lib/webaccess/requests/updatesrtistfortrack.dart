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

class UpdateArtistForTrackResponse {
  final int integer;
  UpdateArtistForTrackResponse(this.integer);

  factory UpdateArtistForTrackResponse.fromJson(Map<String, dynamic> data) {
    final integer = data['integer'];
    return UpdateArtistForTrackResponse(integer);
  }
}
