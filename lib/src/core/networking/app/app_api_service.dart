import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'package:elfulk/src/core/networking/app/app_api_constants.dart';
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
}
