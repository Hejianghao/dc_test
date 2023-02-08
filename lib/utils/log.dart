import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

//use callclass to filter logges
log(dynamic) {
  if (kDebugMode) {
    String trace = StackTrace.current.toString();
    final traceList = trace.split('#1');
    String callClass = '';
    if (traceList.length > 2) {
      callClass = traceList[1].split('.').first;
    }
    Logger().e(dynamic, '$callClass:');
  }
}
