class JukeboxTrackPathAndFileName {
  final int trackId;
  final String trackPath;
  final String trackFileName;

  JukeboxTrackPathAndFileName(this.trackId, this.trackPath, this.trackFileName);

  Map<String, dynamic> toJson() {
    return {
      'Identifier': trackId,
      'TrackPath': trackPath,
      'TrackFileName': trackFileName,
    };
  }
}
