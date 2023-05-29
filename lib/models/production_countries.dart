class ProductionCountries {
  String? iso_3166_1;
  String? name;

  ProductionCountries({
    this.iso_3166_1,
    this.name,
  });
  factory ProductionCountries.fromJson(Map<String, dynamic> json) {
    return ProductionCountries(
      iso_3166_1: json['iso_3166_1'] ?? '',
      name: json['poster_namepath'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'iso_3166_1': iso_3166_1,
        'name': name,
      };
}
