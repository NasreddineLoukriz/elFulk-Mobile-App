import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/error/api_error_model.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/child_features/child_home/data/response_models/child_home_overview_response_model.dart';
import 'package:elfulk/src/features/child_features/child_home/data/repos/child_home_repository.dart';
import 'package:elfulk/src/features/child_features/child_home/data/view_models/child_home_overview_view_model.dart';

part 'child_home_cubit.freezed.dart';
part 'child_home_state.dart';

class ChildHomeCubit extends Cubit<ChildHomeState> {
  ChildHomeCubit(this._repository) : super(const ChildHomeState.initial());

  final ChildHomeRepository _repository;

  Future<void> loadOverview() async {
    emit(const ChildHomeState.loading());

    final ApiResult<ChildHomeOverviewResponseModel> result = await _repository
        .getHomeOverview();
    result.when(
      success: (ChildHomeOverviewResponseModel overview) => emit(
        ChildHomeState.loaded(
          ChildHomeOverviewViewModel.fromResponseModel(overview),
        ),
      ),
      failure: (ApiErrorModel error) => emit(ChildHomeState.error(error)),
    );
  }
}
