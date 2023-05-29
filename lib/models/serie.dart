class Serie {
  String? first_air_date;
  String? backdrop_path;
  List<dynamic>? genre_ids;
  int? id;
  String? title;
  List<dynamic>? origin_country;
  String? original_language;
  String? original_title;
  String? overview;
  double? popularity;
  String? poster_path;
  String? release_date;

  var vote_average;
  int? vote_count;

  factory Serie.fromJson(Map<String, dynamic> json) {
    List<dynamic> genres = [];
    List<dynamic> originCountry = [];

    if (json["genre_ids"] != null) {
      if ((json["genre_ids"] as List).isNotEmpty) {
        genres = json["genre_ids"];
      }
    }
    if (json["origin_country"] != null) {
      if ((json["origin_country"] as List).isNotEmpty) {
        originCountry = json["origin_country"];
      }
    }
    return Serie(
      first_air_date: json["first_air_date"] ?? "",
      backdrop_path: json["backdrop_path"] ?? "",
      genre_ids: genres,
      id: json["id"] ?? 0,
      title: json["name"] ?? '',
      origin_country: originCountry,
      original_language: json["original_language"] ?? "",
      original_title: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"] ?? 0,
      poster_path: json["poster_path"] ?? "",
      release_date: json["release_date"] ?? "",
      vote_average: json["vote_average"] ?? 0.0,
      vote_count: json["vote_count"] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        "first_air_date": first_air_date,
        "backdrop_path": backdrop_path,
        "genre_ids": genre_ids,
        "id": id,
        "name": title,
        "origin_country": origin_country,
        "original_language": original_language,
        "original_title": original_title,
        "overview": overview,
        "popularity": popularity,
        "poster_path": poster_path,
        "release_date": release_date,
        "vote_average": vote_average,
        "vote_count": vote_count,
      };
  Serie({
    this.first_air_date,
    this.backdrop_path,
    this.genre_ids,
    this.id,
    this.title,
    this.origin_country,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.release_date,
    this.vote_average,
    this.vote_count,
  });
}
