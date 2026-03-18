import 'package:elfulk/src/core/networking/child/child_api_service.dart';
import 'package:elfulk/src/core/networking/error/api_error_handler.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/child_features/child_home/data/response_models/child_home_overview_response_model.dart';

class ChildHomeRepository {
  ChildHomeRepository(this._apiService);

  final ChildApiService _apiService;

  Future<ApiResult<ChildHomeOverviewResponseModel>> getHomeOverview() async {
    try {
      final response = await _apiService.getHomeOverview();
      return ApiResult.success(response);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return ApiResult.failure(apiError);
    }
  }
}
