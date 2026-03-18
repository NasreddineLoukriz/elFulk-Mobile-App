import 'package:elfulk/src/core/config/app_environment.dart';

class ApiConstants {
  static const String prodBaseUrl = 'https://api.elfulk.app';
  static const String devBaseUrl = 'https://api.dev.elfulk.app';
}

String apiBaseUrl = ApiConstants.devBaseUrl;

void configureApiBaseUrl(AppEnvironment environment) {
  apiBaseUrl = environment.isProduction
      ? ApiConstants.prodBaseUrl
      : ApiConstants.devBaseUrl;
}
