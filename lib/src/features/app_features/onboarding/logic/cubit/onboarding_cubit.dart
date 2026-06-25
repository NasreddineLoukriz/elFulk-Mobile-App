import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elfulk/src/features/app_features/onboarding/data/view_models/onboarding_page_view_model.dart';
part 'onboarding_cubit.freezed.dart';
part 'onboarding_state.dart';

const String _kOnboardingDoneKey = 'onboarding_complete';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  final int _totalPages = OnboardingData.pages.length;

  void onPageChanged(int index) {
    emit(state.copyWith(
      currentPage: index,
      isLastPage: index == _totalPages - 1,
    ));
  }

  void nextPage() {
    final int next = state.currentPage + 1;
    if (next >= _totalPages) {
      _complete();
    } else {
      emit(state.copyWith(
        currentPage: next,
        isLastPage: next == _totalPages - 1,
      ));
    }
  }

  void skip() => _complete();

  Future<void> _complete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingDoneKey, true);
    emit(state.copyWith(isCompleted: true));
  }

  // static Future<bool> isOnboardingDone() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(_kOnboardingDoneKey) ?? false;
  // }
  static Future<bool> isOnboardingDone() async {
  return false;
}
}
