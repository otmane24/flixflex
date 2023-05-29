class Movie {
  bool? adult;
  String? backdrop_path;
  List<dynamic>? genre_ids;
  int? id;
  String? original_language;
  String? original_title;
  String? overview;
  var popularity;
  String? poster_path;
  String? release_date;
  String? title;
  bool? video;
  var vote_average;
  var vote_count;

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<dynamic> genres = [];

    if (json["genre_ids"] != null) {
      if ((json["genre_ids"] as List).isNotEmpty) {
        genres = json["genre_ids"];
      }
    }
    return Movie(
      adult: json["adult"] ?? "",
      backdrop_path: json["backdrop_path"] ?? "",
      genre_ids: genres,
      id: json["id"] ?? 0,
      original_language: json["original_language"] ?? "",
      original_title: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"] ?? 0,
      poster_path: json["poster_path"] ?? "",
      release_date: json["release_date"] ?? "",
      title: json["title"] ?? "",
      video: json["video"] ?? false,
      vote_average: json["vote_average"] ?? 0.0,
      vote_count: json["vote_count"] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdrop_path,
        "genre_ids": genre_ids,
        "id": id,
        "original_language": original_language,
        "original_title": original_title,
        "overview": overview,
        "popularity": popularity,
        "poster_path": poster_path,
        "release_date": release_date,
        "title": title,
        "video": video,
        "vote_average": vote_average,
        "vote_count": vote_count,
      };
  Movie({
    this.adult,
    this.backdrop_path,
    this.genre_ids,
    this.id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.release_date,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });
}
