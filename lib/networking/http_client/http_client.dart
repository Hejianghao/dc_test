import 'package:dc_test/model/search_data.dart';
import 'package:dc_test/networking/api.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'http_client.g.dart';

@RestApi()
abstract class HttpClient {
  factory HttpClient(Dio dio, {String? baseUrl}) = _HttpClient;

  @GET(Api.getSearchResult)
  Future<List<SearchData>> getSearchResult(
      @Queries() Map<String, dynamic> params);
}
