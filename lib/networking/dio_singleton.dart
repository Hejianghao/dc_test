import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dc_test/networking/common_params.dart';
import 'package:dc_test/networking/network_config.dart';
import 'package:dc_test/networking/restapi_exception.dart';
import 'package:dc_test/utils/log.dart';

class DioSingleton {
  late Dio dio;

  static final DioSingleton _dioSingleton = DioSingleton._internal();

  factory DioSingleton() {
    return _dioSingleton;
  }

  Future<Response> downloadFile(String url, String savePath) async {
    return await dio.download(url, savePath);
  }

  DioSingleton._internal() {
    dio = Dio();

    //setting the base request url
    dio.options.baseUrl =
        kDebugMode ? NetworkConfig.debugUrl : NetworkConfig.releaseUrl;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: _requestInterceptor,
      onResponse: _responseInterceptor,
    ));
  }

  _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) {
    String mobileOS = Platform.isIOS ? 'iOS' : 'Android';
    options.headers.addEntries([
      MapEntry('Authorization',
          CommonParams.token.isEmpty ? '' : 'Bearer ${CommonParams.token}'),
      MapEntry('Accept-Language', CommonParams.languageCode?.countryCode ?? ''),
      MapEntry('MobileOS', mobileOS)
    ]);
    return handler.next(options);
  }

  _responseInterceptor(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    log('dio params:${response.requestOptions.data}\ndio method:${response.requestOptions.method}\ndio url:${response.realUri}\ndio response:$response');
    if (response.data is Map) {
      int code = response.data['code'] ?? -1;
      String msg = response.data['msg'] ?? '';

      //common handle
      if (code != 200) {
        throw RestApiException(msg, code: code);
      }
      response.data = response.data['data'];
    }
    return handler.next(response);
  }
}
