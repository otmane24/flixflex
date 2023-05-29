import 'package:dio/dio.dart';
import 'package:flixflex/data/web_services/detail.dart';
import 'package:flixflex/models/detail_movie.dart';
import 'package:flixflex/models/detail_serie.dart';
import 'package:flixflex/models/tags.dart';
import 'package:flixflex/models/video_movie.dart';

import '../../presentation/laungaes/main.dart';

class DetailRepository {
  final DetailWebService detailWebService;

  DetailRepository(this.detailWebService);

  Future getMovieDetail({required int id}) async {
    try {
      final Response getGenreMoviesResponse =
          await detailWebService.getMovieDetail(id: id);

      if (getGenreMoviesResponse.statusCode == 200) {
        MovieDetail? movieDetail;
        final movieDetailData = getGenreMoviesResponse.data;

        movieDetail = MovieDetail.fromJson(movieDetailData);

        return movieDetail;
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

  Future getTagsMovie({required int id}) async {
    try {
      final Response getTagsMovieResponse =
          await detailWebService.getTagsMovie(id: id);

      if (getTagsMovieResponse.statusCode == 200) {
        List<Tags> tagsList = [];
        final tagsData = getTagsMovieResponse.data['keywords'];
        for (var tag in tagsData) {
          tagsList.add(Tags.fromJson(tag));
        }

        return tagsList;
      }

      if (getTagsMovieResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getTagsMovieResponse.statusCode == 401) {
        return 'Token';
      }
      if (getTagsMovieResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch genre $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getVideoMovie({required int id}) async {
    try {
      final Response getVideoMovieResponse =
          await detailWebService.getVideoMovie(id: id);

      if (getVideoMovieResponse.statusCode == 200) {
        VideoMovie videoMovie;
        final videoMovieData = getVideoMovieResponse.data['results'];
        for (var tag in videoMovieData) {
          if (tag['type'] == 'Trailer') {
            videoMovie = VideoMovie.fromJson(tag);
            return videoMovie;
          }
        }

        return '';
      }

      if (getVideoMovieResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getVideoMovieResponse.statusCode == 401) {
        return 'Token';
      }
      if (getVideoMovieResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch getVideoMovie $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getSerieDetail({required int id}) async {
    try {
      final Response getDetailTvResponse =
          await detailWebService.getSerieDetail(id: id);

      if (getDetailTvResponse.statusCode == 200) {
        SerieDetail? serieDetail;
        final serieDetailData = getDetailTvResponse.data;

        serieDetail = SerieDetail.fromJson(serieDetailData);

        return serieDetail;
      }

      if (getDetailTvResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getDetailTvResponse.statusCode == 401) {
        return 'Token';
      }
      if (getDetailTvResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch genre $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getTagsSerie({required int id}) async {
    try {
      final Response getTagsMovieResponse =
          await detailWebService.getTagsSerie(id: id);

      if (getTagsMovieResponse.statusCode == 200) {
        List<Tags> tagsList = [];
        final tagsData = getTagsMovieResponse.data['results'];
        for (var tag in tagsData) {
          tagsList.add(Tags.fromJson(tag));
        }

        return tagsList;
      }

      if (getTagsMovieResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getTagsMovieResponse.statusCode == 401) {
        return 'Token';
      }
      if (getTagsMovieResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch genre $e');
      return AppLanguage.strings.errorBloc;
    }
  }

  Future getVideoSerie({required int id}) async {
    try {
      final Response getVideoMovieResponse =
          await detailWebService.getVideoSerie(id: id);

      if (getVideoMovieResponse.statusCode == 200) {
        VideoMovie videoMovie;
        final videoMovieData = getVideoMovieResponse.data['results'];
        for (var tag in videoMovieData) {
          if (tag['type'] == 'Trailer') {
            videoMovie = VideoMovie.fromJson(tag);
            return videoMovie;
          }
        }

        return '';
      }

      if (getVideoMovieResponse.statusCode == 500) {
        return 'Suppression';
      }
      if (getVideoMovieResponse.statusCode == 401) {
        return 'Token';
      }
      if (getVideoMovieResponse.statusCode == 403) {
        return 'Premession';
      }
      return AppLanguage.strings.errorBloc;
    } catch (e) {
      print('error carch getVideoMovie $e');
      return AppLanguage.strings.errorBloc;
    }
  }
}
