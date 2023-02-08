class RestApiException implements Exception {
  final String cause;
  final int code;
  const RestApiException(this.cause, {required this.code});
}
