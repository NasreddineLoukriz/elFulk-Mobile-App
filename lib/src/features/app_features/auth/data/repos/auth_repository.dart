import 'package:elfulk/src/core/networking/app/app_api_service.dart';
import 'package:elfulk/src/core/networking/error/api_error_handler.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/app_features/auth/data/request_models/login_request_model.dart';
import 'package:elfulk/src/features/app_features/auth/data/request_models/register_request_model.dart';
import 'package:elfulk/src/features/app_features/auth/data/response_models/auth_response_model.dart';
import 'package:elfulk/src/features/app_features/auth/data/view_models/auth_view_model.dart';

/// مستودع المصادقة: يغلّف نداءات الشبكة ويحوّل الردود إلى نماذج واجهة.
class AuthRepository {
  AuthRepository(this._apiService);

  final AppApiService _apiService;

  /// تسجيل الدخول بالبريد وكلمة المرور.
  Future<ApiResult<AuthViewModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponseModel response = await _apiService.login(
        LoginRequestModel(email: email, password: password),
      );
      return ApiResult.success(_toViewModel(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// إنشاء حساب جديد.
  Future<ApiResult<AuthViewModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponseModel response = await _apiService.register(
        RegisterRequestModel(name: name, email: email, password: password),
      );
      return ApiResult.success(_toViewModel(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  AuthViewModel _toViewModel(AuthResponseModel response) => AuthViewModel(
    userName: response.userName,
    email: response.email,
    isAuthenticated: true,
  );
}
