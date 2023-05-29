import 'package:dio/dio.dart';
import 'package:flixflex/data/web_services/genre.dart';
import 'package:flixflex/models/genre.dart';

import '../../presentation/laungaes/main.dart';

class GenreRepository {
  final GenreWebService genreWebService;

  GenreRepository(this.genreWebService);

  Future getGenreMovies() async {
    try {
      final Response getGenreMoviesResponse =
          await genreWebService.getGenreMovies();

      if (getGenreMoviesResponse.statusCode == 200) {
        List<Genre> genreMovieList = [];
        final genresMvoie = getGenreMoviesResponse.data['genres'];

        for (var genre in genresMvoie) {
          genreMovieList.add(Genre.fromJson(genre));
        }
        return genreMovieList;
      }

      if (getGenreMoviesResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getGenreMoviesResponse.statusCode == 401) {
        return 'Token';
      }
      if (getGenreMoviesResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch genre $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getGenreSeries() async {
    try {
      final Response getGenreMoviesResponse =
          await genreWebService.getGenreSeries();

      if (getGenreMoviesResponse.statusCode == 200) {
        List<Genre> genreMovieList = [];
        final genresMvoie = getGenreMoviesResponse.data['genres'];

        for (var genre in genresMvoie) {
          genreMovieList.add(Genre.fromJson(genre));
        }
        return genreMovieList;
      }

      if (getGenreMoviesResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getGenreMoviesResponse.statusCode == 401) {
        return 'Token';
      }
      if (getGenreMoviesResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch genre $e');
      return AppLanguage.strings.errorBloc;
    }
  }
}
