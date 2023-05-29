import 'package:dio/dio.dart';

import '../../constants/strings/constants_strings.dart';

class DiscoverWebService {
  Dio? dio;

  DiscoverWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        // 'content-type': 'multipart/form-data',
        'content-type': 'application/json',
        'Authorization': headerKey,
      },
    );
    dio = Dio(options);
  }

  Future<dynamic> getMovies({required int nextPage, String? genreId}) async {
    try {
      Response response = await dio!.get(
        '/discover/movie?page=$nextPage&with_genres=$genreId',
      );

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Response(requestOptions: RequestOptions(path: 'path'));
      }
    }
  }

  Future<dynamic> getPopularityMovies() async {
    try {
      Response response = await dio!.get(
        '/movie/top_rated',
      );

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        return e.response!;
      } else {
        print(e.error.toString());
        // Something happened in setting up or sending the request that triggered an Error
        return Response(requestOptions: RequestOptions(path: 'path'));
      }
    }
  }

  Future<dynamic> getPopularitySerie() async {
    try {
      Response response = await dio!.get(
        '/tv/top_rated',
      );

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        return e.response!;
      } else {
        print(e.error.toString());
        // Something happened in setting up or sending the request that triggered an Error
        return Response(requestOptions: RequestOptions(path: 'path'));
      }
    }
  }

  Future<dynamic> getSeries({required int nextPage, String? genreId}) async {
    try {
      Response response = await dio!.get(
        '/discover/tv?page=$nextPage&with_genres=$genreId',
      );

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        return e.response!;
      } else {
        print(e.error.toString());
        // Something happened in setting up or sending the request that triggered an Error
        return Response(requestOptions: RequestOptions(path: 'path'));
      }
    }
  }
}
