import 'package:dio/dio.dart';

import '../../constants/strings/constants_strings.dart';

class SearchWebService {
  Dio? dio;

  SearchWebService() {
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

  Future<dynamic> searchMulti(
      {required int nextPage, required String searchKey}) async {
    try {
      Response response = await dio!.get(
        '/search/multi?query=$searchKey&page=$nextPage',
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
      print('genre response ${response.data}');
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
