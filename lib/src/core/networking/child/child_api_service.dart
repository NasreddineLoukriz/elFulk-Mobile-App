import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'package:elfulk/src/core/networking/child/child_api_constants.dart';
import 'package:elfulk/src/features/child_features/child_home/data/response_models/child_home_overview_response_model.dart';

part 'child_api_service.g.dart';

@RestApi()
abstract class ChildApiService {
  factory ChildApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ChildApiService;

  @GET(ChildApiConstants.homeOverview)
  Future<ChildHomeOverviewResponseModel> getHomeOverview();
}
