class UnDeleteTrackRequest {
  final int trackId;
  UnDeleteTrackRequest(this.trackId);

  Map<String, dynamic> toJson() {
    return {
      'TrackId': trackId,
    };
  }
}
