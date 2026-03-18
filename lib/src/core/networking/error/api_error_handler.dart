import 'package:dio/dio.dart';

import 'package:elfulk/src/core/networking/error/api_error_model.dart';
import 'package:elfulk/src/core/networking/error/api_errors_enum.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            error: error,
            detail: 'Connection to server failed',
            errorType: ApiErrorsEnum.connectionError,
          );
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            error: error,
            detail: 'Connection timeout with the server',
            errorType: ApiErrorsEnum.connectionTimeout,
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            error: error,
            detail: 'Receive timeout in connection with the server',
            errorType: ApiErrorsEnum.receiveTimeout,
          );
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            error: error,
            detail: 'Send timeout in connection with the server',
            errorType: ApiErrorsEnum.sendTimeout,
          );
        case DioExceptionType.cancel:
          return ApiErrorModel(
            error: error,
            detail: 'Request to the server was cancelled',
            errorType: ApiErrorsEnum.cancel,
          );
        case DioExceptionType.badResponse:
          return _handleBadResponse(error);
        case DioExceptionType.unknown:
        default:
          return ApiErrorModel(
            error: error,
            detail: 'Unknown error occurred',
            errorType: ApiErrorsEnum.unknownError,
          );
      }
    }

    return ApiErrorModel(
      error: error,
      detail: 'Unknown error occurred',
      errorType: ApiErrorsEnum.unknownError,
    );
  }

  static ApiErrorModel _handleBadResponse(DioException error) {
    final Response<dynamic>? response = error.response;
    final int? statusCode = response?.statusCode;

    if (statusCode == null) {
      return ApiErrorModel(
        error: error,
        detail: 'Bad response from the server',
        errorType: ApiErrorsEnum.badResponse,
      );
    }

    final ApiErrorsEnum errorType = ApiErrorsEnum.fromStatusCode(statusCode);
    final dynamic payload = response?.data;
    final String detail = payload is Map<String, dynamic>
        ? (payload['detail']?.toString() ?? 'Request failed')
        : 'Request failed';

    return ApiErrorModel(error: error, detail: detail, errorType: errorType);
  }
}
