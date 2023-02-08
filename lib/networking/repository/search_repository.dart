import 'package:dc_test/model/search_data.dart';
import 'package:dio/dio.dart';
import 'package:dc_test/networking/dio_singleton.dart';
import 'package:dc_test/networking/failure.dart';
import 'package:dc_test/networking/http_client/http_client.dart';
import 'package:either_dart/either.dart';
import 'package:dc_test/networking/request_wrapper.dart';

class SearchRepository {
  final Dio _dio = DioSingleton().dio;

  Future<Either<Failure, List<SearchData>>> getSearchResult(
    String text, {
    bool noThrottle = true,
  }) async {
    return tryCatchWrapper<List<SearchData>>(onRequest: () async {
      final result = await HttpClient(_dio).getSearchResult({
        'no-throttling': noThrottle,
        'search': text,
      });
      return result;
    });
  }
}
