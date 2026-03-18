import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:elfulk/src/core/networking/helper/dummy_api_interceptor.dart';

class DioFactory {
  static Dio? _dio;

  DioFactory._();

  static Dio getDio() {
    final Duration timeout = const Duration(seconds: 15);

    if (_dio == null) {
      final Dio dio = Dio()
        ..options.connectTimeout = timeout
        ..options.receiveTimeout = timeout
        ..options.headers = <String, dynamic>{
          'Accept': 'application/json',
          'content-type': 'application/json',
        };

      dio.interceptors.add(DummyApiInterceptor());

      if (kDebugMode) {
        dio.interceptors.add(
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
          ),
        );
      }

      _dio = dio;
    }

    return _dio!;
  }

  static void reset() {
    _dio?.close(force: true);
    _dio = null;
  }
}
