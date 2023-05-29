class Tags {
  int? id;

  String? name;

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
      };
  Tags({
    this.id,
    this.name,
  });
}
