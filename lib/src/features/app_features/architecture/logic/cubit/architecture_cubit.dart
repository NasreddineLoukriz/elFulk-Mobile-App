import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/features/app_features/architecture/data/view_models/architecture_overview_view_model.dart';
import 'package:elfulk/src/features/app_features/architecture/data/repos/architecture_repository.dart';

part 'architecture_cubit.freezed.dart';
part 'architecture_state.dart';

class ArchitectureCubit extends Cubit<ArchitectureState> {
  ArchitectureCubit(this._architectureRepository)
    : super(const ArchitectureState.initial());

  final ArchitectureRepository _architectureRepository;

  Future<void> loadOverview() async {
    emit(const ArchitectureState.loading());

    try {
      final ArchitectureOverviewViewModel overview = _architectureRepository
          .loadOverview();
      emit(ArchitectureState.loaded(overview));
    } catch (error) {
      emit(ArchitectureState.error(error.toString()));
    }
  }
}
