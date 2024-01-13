class ArtistInformation {
  final int id;
  final String name;
  ArtistInformation(this.id, this.name);

  Map<String, dynamic> toJson() {
    return {
      'artistId': id,
      'artistName': name,
    };
  }
}
