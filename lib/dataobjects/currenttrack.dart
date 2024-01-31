class CurrentTrack {
  final int currentTrackId;
  CurrentTrack(this.currentTrackId);

  Map<String, dynamic> toJson() {
    return {
      'currentTrackId': currentTrackId,
    };
  }
}
