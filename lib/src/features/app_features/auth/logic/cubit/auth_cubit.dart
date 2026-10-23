import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/app_features/auth/data/repos/auth_repository.dart';
import 'package:elfulk/src/features/app_features/auth/data/view_models/auth_view_model.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

/// إدارة جلسة الدخول عبر البيانات الوهمية للنسخة التجريبية.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.initial());

  /// رمز التحقق الثابت في النسخة التجريبية (بلا خادم).
  static const String demoOtpCode = '12345';

  final AuthRepository _authRepository;

  /// تسجيل الدخول ثم إعلان الجلسة عند النجاح.
  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    final ApiResult<AuthViewModel> result = await _authRepository.login(
      email: email,
      password: password,
    );
    result.when(
      success: (AuthViewModel user) => emit(AuthState.authenticated(user)),
      failure: (_) => emit(
        const AuthState.failure(
          'تعذّر تسجيل الدخول. تحقّق من البريد الإلكتروني وكلمة المرور.',
        ),
      ),
    );
  }

  /// إنشاء الحساب ثم إعلان الجلسة عند النجاح.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());
    final ApiResult<AuthViewModel> result = await _authRepository.register(
      name: name,
      email: email,
      password: password,
    );
    result.when(
      success: (AuthViewModel user) => emit(AuthState.authenticated(user)),
      failure: (_) => emit(
        const AuthState.failure('تعذّر إنشاء الحساب. حاول مرة أخرى.'),
      ),
    );
  }

  /// إعادة الحالة الابتدائية عند مغادرة شاشات المصادقة.
  void reset() => emit(const AuthState.initial());
}
