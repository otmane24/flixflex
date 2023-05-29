class ProductionCompanies {
  int? id;
  String? logo_path;
  String? name;
  String? origin_country;
  ProductionCompanies({
    this.id,
    this.logo_path,
    this.name,
    this.origin_country,
  });
  factory ProductionCompanies.fromJson(Map<String, dynamic> json) {
    return ProductionCompanies(
      id: json['id'] ?? 0,
      logo_path: json['logo_path'] ?? '',
      name: json['poster_namepath'] ?? '',
      origin_country: json['origin_country'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'logo_path': logo_path,
        'name': name,
        'origin_country': origin_country,
      };
}
