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

class PlaceholderWebApiResponse {
  final int integer;
  PlaceholderWebApiResponse(this.integer);

  Map<String, dynamic> toJson() {
    return {
      'integer': integer,
    };
  }

  factory PlaceholderWebApiResponse.fromJson(Map<String, dynamic> data) {
    final integer = data['integer'];
    return PlaceholderWebApiResponse(integer);
  }
}
