import 'package:dio/dio.dart';
import 'package:dc_test/networking/failure.dart';
import 'package:dc_test/networking/restapi_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<Either<Failure, T>> tryCatchWrapper<T>({
  required Future<T> Function() onRequest,
  Function()? onError,
}) async {
  try {
    final result = await onRequest();
    return Right(result);
  } on DioError catch (e) {
    if (onError != null) {
      onError();
    }
    if (e.error is RestApiException) {
      String msg = RestApiError.errorMsg(e.error.code);
      EasyLoading.showToast(msg);
      return Left(Failure(
        msg: msg,
        code: e.error.code,
      ));
    } else {
      return const Left(Failure(
        msg: 'Request Failed',
        code: -1,
      ));
    }
  } catch (e) {
    if (onError != null) {
      onError();
    }
    return const Left(Failure(
      msg: 'Request Failed',
      code: -1,
    ));
  }
}

class RestApiError {
  static String errorMsg(int code) {
    late String msg;
    switch (code) {
      case 404:
        msg = 'API not found';
        break;
      case 400:
        msg = 'The Parameter is incorrect';
        break;
      case 500:
        msg = 'Unknown error';
        break;
      default:
        msg = 'Request Failed';
    }
    return msg;
  }
}
