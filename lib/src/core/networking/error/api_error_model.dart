import 'package:elfulk/src/core/networking/error/api_errors_enum.dart';

class ApiErrorModel {
  ApiErrorModel({
    required this.error,
    required this.detail,
    required this.errorType,
  });

  final dynamic error;
  final String detail;
  final ApiErrorsEnum errorType;
}
