import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'package:elfulk/src/core/networking/app/app_api_constants.dart';
import 'package:elfulk/src/features/app_features/auth/data/request_models/login_request_model.dart';
import 'package:elfulk/src/features/app_features/auth/data/request_models/register_request_model.dart';
import 'package:elfulk/src/features/app_features/auth/data/response_models/auth_response_model.dart';
import 'package:elfulk/src/features/app_features/home/data/response_models/home_overview_response_model.dart';

part 'app_api_service.g.dart';

@RestApi()
abstract class AppApiService {
  factory AppApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AppApiService;

  @GET(AppApiConstants.homeOverview)
  Future<HomeOverviewResponseModel> getHomeOverview();

  /// تسجيل الدخول (يرد عليه الـ dummy interceptor في النسخة التجريبية).
  @POST(AppApiConstants.login)
  Future<AuthResponseModel> login(@Body() LoginRequestModel body);

  /// إنشاء حساب جديد (يرد عليه الـ dummy interceptor في النسخة التجريبية).
  @POST(AppApiConstants.register)
  Future<AuthResponseModel> register(@Body() RegisterRequestModel body);
}
