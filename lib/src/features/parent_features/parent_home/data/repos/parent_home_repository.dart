import 'package:elfulk/src/core/networking/error/api_error_handler.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/core/networking/parent/parent_api_service.dart';
import 'package:elfulk/src/features/parent_features/parent_home/data/response_models/parent_home_overview_response_model.dart';

class ParentHomeRepository {
  ParentHomeRepository(this._apiService);

  final ParentApiService _apiService;

  Future<ApiResult<ParentHomeOverviewResponseModel>> getHomeOverview() async {
    try {
      final response = await _apiService.getHomeOverview();
      return ApiResult.success(response);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return ApiResult.failure(apiError);
    }
  }
}
