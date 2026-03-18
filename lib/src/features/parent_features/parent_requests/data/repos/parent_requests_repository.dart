import 'package:elfulk/src/core/networking/error/api_error_handler.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/core/networking/parent/parent_api_service.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/request_models/create_parent_request_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/response_models/parent_requests_overview_response_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/request_models/patch_parent_request_status_model.dart';

class ParentRequestsRepository {
  ParentRequestsRepository(this._apiService);

  final ParentApiService _apiService;

  Future<ApiResult<ParentRequestsOverviewResponseModel>> getOverview() async {
    try {
      final response = await _apiService.getRequestsOverview();
      return ApiResult.success(response);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return ApiResult.failure(apiError);
    }
  }

  Future<ApiResult<ParentRequestItemResponseModel>> createRequest(
    CreateParentRequestModel requestBody,
  ) async {
    try {
      final response = await _apiService.createRequest(requestBody);
      return ApiResult.success(response);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return ApiResult.failure(apiError);
    }
  }

  Future<ApiResult<ParentRequestItemResponseModel>> updateRequestStatus(
    String requestId,
    PatchParentRequestStatusModel requestBody,
  ) async {
    try {
      final response = await _apiService.updateRequestStatus(
        requestId,
        requestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return ApiResult.failure(apiError);
    }
  }
}
