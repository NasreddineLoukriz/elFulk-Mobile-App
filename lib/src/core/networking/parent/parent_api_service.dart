import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'package:elfulk/src/core/networking/parent/parent_api_constants.dart';
import 'package:elfulk/src/features/parent_features/parent_home/data/response_models/parent_home_overview_response_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/request_models/create_parent_request_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/response_models/parent_requests_overview_response_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/request_models/patch_parent_request_status_model.dart';

part 'parent_api_service.g.dart';

@RestApi()
abstract class ParentApiService {
  factory ParentApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ParentApiService;

  @GET(ParentApiConstants.homeOverview)
  Future<ParentHomeOverviewResponseModel> getHomeOverview();

  @GET(ParentApiConstants.requestsOverview)
  Future<ParentRequestsOverviewResponseModel> getRequestsOverview();

  @POST(ParentApiConstants.requestsOverview)
  Future<ParentRequestItemResponseModel> createRequest(
    @Body() CreateParentRequestModel requestBody,
  );

  @PATCH(ParentApiConstants.requestDetails)
  Future<ParentRequestItemResponseModel> updateRequestStatus(
    @Path('requestId') String requestId,
    @Body() PatchParentRequestStatusModel requestBody,
  );
}
