class JukeboxCollection {
  int id;
  String name;
  JukeboxCollection(this.id, this.name);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
