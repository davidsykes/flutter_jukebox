class SetTrackDeletedRequest {
  final int trackId;
  final bool isDeleted;
  SetTrackDeletedRequest(this.trackId, this.isDeleted);

  Map<String, dynamic> toJson() {
    return {'TrackId': trackId, 'IsDeleted': isDeleted};
  }
}
