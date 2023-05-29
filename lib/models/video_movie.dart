class VideoMovie {
  String? id;
  String? name;
  String? key;
  String? site;
  String? type;

  factory VideoMovie.fromJson(Map<String, dynamic> json) {
    return VideoMovie(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      key: json["key"] ?? "",
      site: json["site"] ?? "",
      type: json["type"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
        "key": key,
        "site": site,
        "type": type,
      };
  VideoMovie({
    this.id,
    this.name,
    this.key,
    this.site,
    this.type,
  });
}
