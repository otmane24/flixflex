import 'package:dio/dio.dart';

import '../../constants/strings/constants_strings.dart';

class GenreWebService {
  Dio? dio;

  GenreWebService() {
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

  Future<dynamic> getGenreMovies() async {
    try {
      Response response = await dio!.get(
        '/genre/movie/list?language=en',
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

  Future<dynamic> getGenreSeries() async {
    try {
      Response response = await dio!.get(
        '/genre/tv/list?language=en',
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
