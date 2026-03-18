import 'package:elfulk/src/core/networking/error/api_error_handler.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/core/networking/app/app_api_service.dart';
import 'package:elfulk/src/features/app_features/home/data/response_models/home_overview_response_model.dart';

class HomeRepository {
  HomeRepository(this._apiService);

  final AppApiService _apiService;

  Future<ApiResult<HomeOverviewResponseModel>> getHomeOverview() async {
    try {
      final response = await _apiService.getHomeOverview();
      return ApiResult.success(response);
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      return ApiResult.failure(apiError);
    }
  }
}
