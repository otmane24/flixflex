import 'package:dio/dio.dart';
import 'package:flixflex/data/web_services/search.dart';
import 'package:flixflex/models/movie.dart';
import 'package:flixflex/models/serie.dart';

import '../../presentation/laungaes/main.dart';

class SearchRepository {
  final SearchWebService searchWebService;

  SearchRepository(this.searchWebService);

  Future searchMulti({required int nextPage, required String searchKey}) async {
    try {
      final Response searchMultiResponse = await searchWebService.searchMulti(
          nextPage: nextPage, searchKey: searchKey);

      if (searchMultiResponse.statusCode == 200) {
        List<Serie> seriesList = [];
        List<Movie> moviesList = [];
        final searchResult = searchMultiResponse.data['results'];

        for (var search in searchResult) {
          print('search Multi repository movie ${search['genre_ids']}');
          if (search['media_type'] == 'movie') {
            moviesList.add(Movie.fromJson(search));
          } else {
            seriesList.add(Serie.fromJson(search));
          }
        }
        return {'movie': moviesList, 'tv': seriesList};
      }

      if (searchMultiResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (searchMultiResponse.statusCode == 401) {
        return 'Token';
      }
      if (searchMultiResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch search multi $e');
      return AppLanguage.strings.errorBloc;
    }
  }
}
