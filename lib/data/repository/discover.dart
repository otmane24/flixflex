import 'package:dio/dio.dart';
import 'package:flixflex/models/movie.dart';
import 'package:flixflex/models/serie.dart';
import 'package:flutter/material.dart';

import '../../presentation/laungaes/main.dart';
import '../web_services/discover.dart';

class DiscoverRepository {
  final DiscoverWebService discoverWebService;

  DiscoverRepository(this.discoverWebService);

  Future getMovies({required int nextPage, String? genreId}) async {
    try {
      final Response getMoviesResponse = await discoverWebService.getMovies(
          nextPage: nextPage, genreId: genreId);

      if (getMoviesResponse.statusCode == 200) {
        List<Movie> moviesList = [];
        final movies = getMoviesResponse.data['results'];

        for (var movie in movies) {
          moviesList.add(Movie.fromJson(movie));
        }
        return moviesList;
      }

      if (getMoviesResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getMoviesResponse.statusCode == 401) {
        return 'Token';
      }
      if (getMoviesResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch login $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getPopularityMovies() async {
    try {
      final Response getMoviesResponse =
          await discoverWebService.getPopularityMovies();

      if (getMoviesResponse.statusCode == 200) {
        List<Movie> moviesList = [];
        final movies = getMoviesResponse.data['results'];

        for (var movie in movies) {
          moviesList.add(Movie.fromJson(movie));
        }
        print('lasd ${moviesList.length}');
        return moviesList;
      }

      if (getMoviesResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getMoviesResponse.statusCode == 401) {
        return 'Token';
      }
      if (getMoviesResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch getPopularityMovies $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getPopularitySerie() async {
    try {
      final Response getSeriePopularityResponse =
          await discoverWebService.getPopularitySerie();

      if (getSeriePopularityResponse.statusCode == 200) {
        List<Serie> serieList = [];
        final Sreies = getSeriePopularityResponse.data['results'];

        for (var serie in Sreies) {
          serieList.add(Serie.fromJson(serie));
        }

        return serieList;
      }

      if (getSeriePopularityResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getSeriePopularityResponse.statusCode == 401) {
        return 'Token';
      }
      if (getSeriePopularityResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch getPopularitySerie DiscoverRepository $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getSeries({required int nextPage, String? genreId}) async {
    try {
      final Response getSeriesResponse = await discoverWebService.getSeries(
          nextPage: nextPage, genreId: genreId);

      if (getSeriesResponse.statusCode == 200) {
        List<Serie> seriesList = [];
        final series = getSeriesResponse.data['results'];

        for (var serie in series) {
          seriesList.add(Serie.fromJson(serie));
        }
        return seriesList;
      }

      if (getSeriesResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getSeriesResponse.statusCode == 401) {
        return 'Token';
      }
      if (getSeriesResponse.statusCode == 403) {
        return 'Premession';
      }
      print('error carch seriesList ');
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch seriesList $e');
      return AppLanguage.strings.errorBloc;
    }
  }
}
