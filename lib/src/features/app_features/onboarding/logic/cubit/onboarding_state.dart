part of 'onboarding_cubit.dart';

@freezed
sealed class OnboardingState with _$OnboardingState {
  const OnboardingState._(); 

  const factory OnboardingState({
    @Default(0) int currentPage,
    @Default(false) bool isLastPage,
    @Default(false) bool isCompleted,
  }) = _OnboardingState;
}