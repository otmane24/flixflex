import 'package:flixflex/models/genre.dart';
import 'package:flixflex/models/production_companies.dart';
import 'package:flixflex/models/production_countries.dart';
import 'package:flixflex/models/spoken_languages.dart';

class SerieDetail {
  bool? adult;
  String? backdrop_path;
  List<CreatedBy>? created_by;
  List<dynamic>? episode_run_time;
  String? first_air_date;
  List<Genre>? genres;
  String? homepage;
  int? id;
  bool? in_production;
  List<dynamic>? languages;
  String? last_air_date;
  LastEpisodeAir? last_episode_to_air;
  String? name;
  LastEpisodeAir? next_episode_to_air;
  List<Network>? networks;
  var number_of_episodes;
  var number_of_seasons;
  List<dynamic>? origin_country;
  String? original_language;
  String? original_name;
  String? overview;
  var popularity;
  String? poster_path;
  List<ProductionCompanies>? production_companies;
  List<ProductionCountries>? production_countries;
  List<Season>? seasons;
  List<SpokenLanguages>? spoken_languages;
  String? status;
  String? tagline;
  String? type;
  var vote_average;
  var vote_count;

  factory SerieDetail.fromJson(Map<String, dynamic> json) {
    List<CreatedBy> createdByList = [];
    List<Genre> genresList = [];
    List<Network> networkList = [];
    List<ProductionCompanies> productionCompaniesList = [];
    List<ProductionCountries> productionCountriesList = [];
    List<Season> seasonList = [];
    List<SpokenLanguages> spokenLanguagesList = [];

    if (json["created_by"] != null) {
      if ((json["created_by"] as List).isNotEmpty) {
        for (var createdBy in (json["created_by"] as List)) {
          createdByList.add(CreatedBy.fromJson(createdBy));
        }
      }
    }
    if (json["genres"] != null) {
      if ((json["genres"] as List).isNotEmpty) {
        for (var genre in (json["genres"] as List)) {
          genresList.add(Genre.fromJson(genre));
        }
      }
    }
    if (json["networks"] != null) {
      if ((json["networks"] as List).isNotEmpty) {
        for (var network in (json["networks"] as List)) {
          networkList.add(Network.fromJson(network));
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
    if (json["seasons"] != null) {
      if ((json["seasons"] as List).isNotEmpty) {
        for (var season in (json["seasons"] as List)) {
          seasonList.add(Season.fromJson(season));
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
    return SerieDetail(
      adult: json["adult"] ?? "",
      backdrop_path: json["backdrop_path"] ?? "",
      created_by: createdByList,
      episode_run_time: json["episode_run_time"] ?? [],
      first_air_date: json["first_air_date"] ?? "",
      genres: genresList,
      homepage: json["homepage"] ?? "",
      id: json["id"] ?? 0,
      in_production: json["in_production"] ?? false,
      languages:
          json["languages"] != null ? (json["languages"] as List<dynamic>) : [],
      last_air_date: json["last_air_date"] ?? "",
      last_episode_to_air: json["last_air_date"] != null
          ? LastEpisodeAir.fromJson(json['last_episode_to_air'])
          : LastEpisodeAir(),
      name: json["name"] ?? "",
      next_episode_to_air: json["next_episode_to_air"] != null
          ? LastEpisodeAir.fromJson(json['next_episode_to_air'])
          : LastEpisodeAir(),
      networks: networkList,
      number_of_episodes: json["number_of_episodes"] ?? 0,
      number_of_seasons: json["number_of_seasons"] ?? 0,
      origin_country: json["origin_country"] != null
          ? (json["origin_country"] as List<dynamic>)
          : [],
      original_language: json["original_language"] ?? "",
      original_name: json["original_name"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"] ?? 0,
      poster_path: json["poster_path"] ?? "",
      production_companies: productionCompaniesList,
      production_countries: productionCountriesList,
      seasons: seasonList,
      spoken_languages: spokenLanguagesList,
      status: json["status"] ?? "",
      tagline: json["tagline"] ?? "",
      type: json["type"] ?? "",
      vote_average: json["vote_average"] ?? 0.0,
      vote_count: json["vote_count"] ?? 0,
    );
  }
  SerieDetail({
    this.adult,
    this.backdrop_path,
    this.created_by,
    this.episode_run_time,
    this.first_air_date,
    this.genres,
    this.homepage,
    this.id,
    this.in_production,
    this.languages,
    this.last_air_date,
    this.last_episode_to_air,
    this.name,
    this.next_episode_to_air,
    this.networks,
    this.number_of_episodes,
    this.number_of_seasons,
    this.origin_country,
    this.original_language,
    this.original_name,
    this.overview,
    this.popularity,
    this.poster_path,
    this.production_companies,
    this.production_countries,
    this.seasons,
    this.spoken_languages,
    this.status,
    this.tagline,
    this.type,
    this.vote_average,
    this.vote_count,
  });
}

class CreatedBy {
  int? id;
  String? credit_id;
  String? name;
  var gender;

  String? profile_path;

  CreatedBy({
    this.id,
    this.credit_id,
    this.name,
    this.gender,
    this.profile_path,
  });
  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'] ?? 0,
      credit_id: json['credit_id'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? 0,
      profile_path: json['profile_path'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'credit_id': credit_id,
        'name': name,
        'gender': gender,
        'profile_path': profile_path,
      };
}

class Network {
  int? id;
  String? logo_path;
  String? name;
  String? origin_country;

  Network({
    this.id,
    this.logo_path,
    this.name,
    this.origin_country,
  });
  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'] ?? 0,
      logo_path: json['logo_path'] ?? '',
      name: json['name'] ?? '',
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

class Season {
  String? air_date;
  var episode_count;
  int? id;
  String? name;
  String? overview;
  String? poster_path;
  var season_number;

  Season({
    this.air_date,
    this.episode_count,
    this.id,
    this.name,
    this.overview,
    this.poster_path,
    this.season_number,
  });
  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      air_date: json['air_date'] ?? '',
      episode_count: json['episode_count'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      poster_path: json['poster_path'] ?? '',
      season_number: json['season_number'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        'air_date': air_date,
        'episode_count': episode_count,
        'id': id,
        'name': name,
        'overview': overview,
        'poster_path': poster_path,
        'season_number': season_number,
      };
}

class LastEpisodeAir {
  int? id;
  String? name;
  String? overview;
  var vote_average;
  var vote_count;
  String? air_date;
  var episode_number;
  String? production_code;
  var runtime;
  var season_number;
  var show_id;
  String? still_path;

  LastEpisodeAir({
    this.id,
    this.name,
    this.overview,
    this.vote_average,
    this.vote_count,
    this.air_date,
    this.episode_number,
    this.production_code,
    this.runtime,
    this.season_number,
    this.show_id,
    this.still_path,
  });
  factory LastEpisodeAir.fromJson(Map<String, dynamic> json) {
    return LastEpisodeAir(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      vote_average: json['vote_average'] ?? '',
      vote_count: json['vote_count'] ?? '',
      air_date: json['air_date'] ?? '',
      episode_number: json['episode_number'] ?? '',
      production_code: json['production_code'] ?? '',
      runtime: json['runtime'] ?? '',
      season_number: json['season_number'] ?? 0,
      show_id: json['show_id'] ?? '',
      still_path: json['still_path'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'vote_average': vote_average,
        'vote_count': vote_count,
        'air_date': air_date,
        'episode_number': episode_number,
        'production_code': production_code,
        'runtime': runtime,
        'season_number': season_number,
        'show_id': show_id,
        'still_path': still_path,
      };
}
