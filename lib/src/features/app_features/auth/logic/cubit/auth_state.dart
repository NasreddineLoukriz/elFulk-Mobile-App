part of 'auth_cubit.dart';

/// حالات جلسة المصادقة.
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(AuthViewModel user) = AuthAuthenticated;
  const factory AuthState.failure(String message) = AuthFailure;
}
