import 'package:flixflex/models/genre.dart';
import 'package:flixflex/models/production_companies.dart';
import 'package:flixflex/models/production_countries.dart';
import 'package:flixflex/models/spoken_languages.dart';

class MovieDetail {
  bool? adult;
  String? backdrop_path;
  BelongsCollection? belongs_to_collection;
  var budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdb_id;
  String? original_language;
  String? original_title;
  String? overview;
  var popularity;
  String? poster_path;
  List<ProductionCompanies>? production_companies;
  List<ProductionCountries>? production_countries;
  String? release_date;
  var revenue;
  var runtime;
  List<SpokenLanguages>? spoken_languages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  var vote_average;
  var vote_count;

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    List<Genre> genresList = [];
    List<ProductionCompanies> productionCompaniesList = [];
    List<ProductionCountries> productionCountriesList = [];
    List<SpokenLanguages> spokenLanguagesList = [];

    if (json["genres"] != null) {
      if ((json["genres"] as List).isNotEmpty) {
        for (var genre in (json["genres"] as List)) {
          genresList.add(Genre.fromJson(genre));
        }
      }
    }
    if (json["production_companies"] != null) {
      if ((json["production_companies"] as List).isNotEmpty) {
        for (var productionCompanie in (json["production_companies"] as List)) {
          productionCompaniesList
              .add(ProductionCompanies.fromJson(productionCompanie));
        }
      }
    }
    if (json["production_countries"] != null) {
      if ((json["production_countries"] as List).isNotEmpty) {
        for (var productionCountrie in (json["production_countries"] as List)) {
          productionCountriesList
              .add(ProductionCountries.fromJson(productionCountrie));
        }
      }
    }
    if (json["spoken_languages"] != null) {
      if ((json["spoken_languages"] as List).isNotEmpty) {
        for (var spokenLanguage in (json["spoken_languages"] as List)) {
          spokenLanguagesList.add(SpokenLanguages.fromJson(spokenLanguage));
        }
      }
    }
    return MovieDetail(
      adult: json["adult"] ?? "",
      backdrop_path: json["backdrop_path"] ?? "",
      belongs_to_collection: (json['belongs_to_collection'] != null &&
              json['belongs_to_collection'] != '')
          ? BelongsCollection.fromJson(json['belongs_to_collection'])
          : null,
      budget: json["budget"] ?? 0,
      genres: genresList,
      homepage: json["homepage"] ?? "",
      id: json["id"] ?? 0,
      imdb_id: json["imdb_id"] ?? "",
      original_language: json["original_language"] ?? "",
      original_title: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"] ?? 0,
      poster_path: json["poster_path"] ?? "",
      production_companies: productionCompaniesList,
      production_countries: productionCountriesList,
      release_date: json["release_date"] ?? "",
      revenue: json["revenue"] ?? 0,
      runtime: json["runtime"] ?? 0,
      spoken_languages: spokenLanguagesList,
      status: json["status"] ?? "",
      tagline: json["tagline"] ?? "",
      title: json["title"] ?? "",
      video: json["video"] ?? false,
      vote_average: json["vote_average"] ?? 0.0,
      vote_count: json["vote_count"] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdrop_path,
        "belongs_to_collection": belongs_to_collection != null
            ? belongs_to_collection!.toJson()
            : null,
        "budget": budget,
        "genres": genres,
        "homepage": homepage,
        "id": id,
        "imdb_id": imdb_id,
        "original_language": original_language,
        "original_title": original_title,
        "overview": overview,
        "popularity": popularity,
        "poster_path": poster_path,
        "production_companies": production_companies,
        "production_countries": production_countries,
        "release_date": release_date,
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": spoken_languages,
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": vote_average,
        "vote_count": vote_count,
      };
  MovieDetail({
    this.adult,
    this.backdrop_path,
    this.belongs_to_collection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdb_id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.production_companies,
    this.production_countries,
    this.release_date,
    this.revenue,
    this.runtime,
    this.spoken_languages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });
}

class BelongsCollection {
  int? id;
  String? name;
  String? poster_path;
  String? backdrop_path;
  BelongsCollection({
    this.id,
    this.name,
    this.poster_path,
    this.backdrop_path,
  });
  factory BelongsCollection.fromJson(Map<String, dynamic> json) {
    return BelongsCollection(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      poster_path: json['poster_path'] ?? '',
      backdrop_path: json['backdrop_path'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'poster_path': poster_path,
        'backdrop_path': backdrop_path,
      };
}
