import 'package:dio/dio.dart';

import '../../constants/strings/constants_strings.dart';

class DetailWebService {
  Dio? dio;

  DetailWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'content-type': 'application/json',
        'Authorization': headerKey,
      },
    );
    dio = Dio(options);
  }

  Future<dynamic> getMovieDetail({required int id}) async {
    try {
      Response response = await dio!.get(
        '/movie/$id',
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

  Future<dynamic> getTagsMovie({required int id}) async {
    try {
      Response response = await dio!.get(
        '/movie/$id/keywords',
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

  Future<dynamic> getVideoMovie({required int id}) async {
    try {
      Response response = await dio!.get(
        '/movie/$id/videos',
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

  Future<dynamic> getSerieDetail({required int id}) async {
    try {
      Response response = await dio!.get(
        '/tv/$id',
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

  Future<dynamic> getTagsSerie({required int id}) async {
    try {
      Response response = await dio!.get(
        '/tv/$id/keywords',
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

  Future<dynamic> getVideoSerie({required int id}) async {
    try {
      Response response = await dio!.get(
        '/tv/$id/videos',
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
