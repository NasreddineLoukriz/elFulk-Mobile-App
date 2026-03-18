import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/networking/error/api_error_model.dart';
import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/request_models/create_parent_request_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/response_models/parent_requests_overview_response_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/request_models/patch_parent_request_status_model.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/repos/parent_requests_repository.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/view_models/parent_requests_overview_view_model.dart';

part 'parent_requests_bloc.freezed.dart';
part 'parent_requests_event.dart';
part 'parent_requests_state.dart';

class ParentRequestsBloc
    extends Bloc<ParentRequestsEvent, ParentRequestsState> {
  ParentRequestsBloc(this._repository)
    : super(const ParentRequestsState.initial()) {
    on<ParentRequestsLoadDataEvent>(_loadData);
    on<ParentRequestsCreateRequestEvent>(_createRequest);
    on<ParentRequestsUpdateRequestStatusEvent>(_updateRequestStatus);
    on<ParentRequestsClearFeedbackEvent>(_clearFeedback);
  }

  final ParentRequestsRepository _repository;

  Future<void> _loadData(
    ParentRequestsLoadDataEvent event,
    Emitter<ParentRequestsState> emit,
  ) async {
    emit(const ParentRequestsState.loading());
    await _emitOverview(emit);
  }

  Future<void> _createRequest(
    ParentRequestsCreateRequestEvent event,
    Emitter<ParentRequestsState> emit,
  ) async {
    final ParentRequestsLoaded? loadedState = state.maybeMap(
      loaded: (ParentRequestsLoaded state) => state,
      orElse: () => null,
    );
    if (loadedState != null) {
      emit(
        loadedState.copyWith(isCreatingRequest: true, feedbackMessage: null),
      );
    }

    final CreateParentRequestModel requestModel = CreateParentRequestModel(
      childName: event.childName,
      requestType: event.requestType,
      note: event.note,
    );
    final ApiResult<ParentRequestItemResponseModel> result = await _repository
        .createRequest(requestModel);
    switch (result) {
      case Success<ParentRequestItemResponseModel>():
        await _emitOverview(
          emit,
          feedbackMessage:
              'POST ${event.requestType} completed with CreateParentRequestModel.',
        );
      case Failure<ParentRequestItemResponseModel>(
        apiErrorModel: final ApiErrorModel error,
      ):
        emit(ParentRequestsState.error(error));
    }
  }

  Future<void> _updateRequestStatus(
    ParentRequestsUpdateRequestStatusEvent event,
    Emitter<ParentRequestsState> emit,
  ) async {
    final ParentRequestsLoaded? loadedState = state.maybeMap(
      loaded: (ParentRequestsLoaded state) => state,
      orElse: () => null,
    );
    if (loadedState != null) {
      emit(
        loadedState.copyWith(isUpdatingRequest: true, feedbackMessage: null),
      );
    }

    final PatchParentRequestStatusModel requestModel =
        PatchParentRequestStatusModel(
          status: event.status,
          reviewNote: event.reviewNote,
        );
    final ApiResult<ParentRequestItemResponseModel> result = await _repository
        .updateRequestStatus(event.requestId, requestModel);
    switch (result) {
      case Success<ParentRequestItemResponseModel>():
        await _emitOverview(
          emit,
          feedbackMessage:
              'PATCH ${event.requestId} completed with PatchParentRequestStatusModel.',
        );
      case Failure<ParentRequestItemResponseModel>(
        apiErrorModel: final ApiErrorModel error,
      ):
        emit(ParentRequestsState.error(error));
    }
  }

  void _clearFeedback(
    ParentRequestsClearFeedbackEvent event,
    Emitter<ParentRequestsState> emit,
  ) {
    state.maybeMap(
      loaded: (ParentRequestsLoaded loadedState) {
        emit(loadedState.copyWith(feedbackMessage: null));
      },
      orElse: () {},
    );
  }

  Future<void> _emitOverview(
    Emitter<ParentRequestsState> emit, {
    String? feedbackMessage,
  }) async {
    final ApiResult<ParentRequestsOverviewResponseModel> result =
        await _repository.getOverview();
    result.when(
      success: (ParentRequestsOverviewResponseModel overview) => emit(
        ParentRequestsState.loaded(
          overview: ParentRequestsOverviewViewModel.fromResponseModel(overview),
          feedbackMessage: feedbackMessage,
        ),
      ),
      failure: (ApiErrorModel error) => emit(ParentRequestsState.error(error)),
    );
  }
}
