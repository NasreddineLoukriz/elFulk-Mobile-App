import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/error/api_error_model.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/app_features/home/data/response_models/home_overview_response_model.dart';
import 'package:elfulk/src/features/app_features/home/data/repos/home_repository.dart';
import 'package:elfulk/src/features/app_features/home/data/view_models/home_overview_view_model.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(const HomeState.initial());

  final HomeRepository _homeRepository;

  Future<void> loadOverview() async {
    emit(const HomeState.loading());

    final ApiResult<HomeOverviewResponseModel> result = await _homeRepository
        .getHomeOverview();
    result.when(
      success: (HomeOverviewResponseModel overview) => emit(
        HomeState.loaded(HomeOverviewViewModel.fromResponseModel(overview)),
      ),
      failure: (ApiErrorModel error) => emit(HomeState.error(error)),
    );
  }
}
