import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/error/api_error_model.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/parent_features/parent_home/data/response_models/parent_home_overview_response_model.dart';
import 'package:elfulk/src/features/parent_features/parent_home/data/repos/parent_home_repository.dart';
import 'package:elfulk/src/features/parent_features/parent_home/data/view_models/parent_home_overview_view_model.dart';

part 'parent_home_cubit.freezed.dart';
part 'parent_home_state.dart';

class ParentHomeCubit extends Cubit<ParentHomeState> {
  ParentHomeCubit(this._repository) : super(const ParentHomeState.initial());

  final ParentHomeRepository _repository;

  Future<void> loadOverview() async {
    emit(const ParentHomeState.loading());

    final ApiResult<ParentHomeOverviewResponseModel> result = await _repository
        .getHomeOverview();
    result.when(
      success: (ParentHomeOverviewResponseModel overview) => emit(
        ParentHomeState.loaded(
          ParentHomeOverviewViewModel.fromResponseModel(overview),
        ),
      ),
      failure: (ApiErrorModel error) => emit(ParentHomeState.error(error)),
    );
  }
}
