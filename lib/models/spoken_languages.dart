class SpokenLanguages {
  String? english_name;
  String? iso_639_1;
  String? name;

  SpokenLanguages({
    this.english_name,
    this.iso_639_1,
    this.name,
  });
  factory SpokenLanguages.fromJson(Map<String, dynamic> json) {
    return SpokenLanguages(
      english_name: json['english_name'] ?? '',
      iso_639_1: json['iso_639_1'] ?? '',
      name: json['poster_namepath'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'english_name': english_name,
        'iso_639_1': iso_639_1,
        'name': name,
      };
}
