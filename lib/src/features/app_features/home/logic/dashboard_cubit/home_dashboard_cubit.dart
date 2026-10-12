import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/error/api_error_model.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/app_features/home/data/models/dashboard_models.dart';
import 'package:elfulk/src/features/app_features/home/data/repos/home_dashboard_repository.dart';

part 'home_dashboard_cubit.freezed.dart';
part 'home_dashboard_state.dart';

/// يدير بيانات لوحة الرئيسية (تُستهلك في `home` و`parent_home`).
class HomeDashboardCubit extends Cubit<HomeDashboardState> {
  HomeDashboardCubit(this._repository)
    : super(const HomeDashboardState.initial());

  final HomeDashboardRepository _repository;

  Future<void> load() async {
    emit(const HomeDashboardState.loading());

    final ApiResult<HomeDashboard> result = await _repository.fetchDashboard();
    result.when(
      success: (HomeDashboard dashboard) =>
          emit(HomeDashboardState.loaded(dashboard)),
      failure: (ApiErrorModel error) => emit(HomeDashboardState.error(error)),
    );
  }
}
