class Genre {
  int? id;

  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
      };
  Genre({
    this.id,
    this.name,
  });
}
