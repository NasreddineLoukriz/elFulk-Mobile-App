part of 'parent_requests_bloc.dart';

@freezed
class ParentRequestsState with _$ParentRequestsState {
  const factory ParentRequestsState.initial() = _Initial;
  const factory ParentRequestsState.loading() = ParentRequestsLoading;
  const factory ParentRequestsState.loaded({
    required ParentRequestsOverviewViewModel overview,
    @Default(false) bool isCreatingRequest,
    @Default(false) bool isUpdatingRequest,
    String? feedbackMessage,
  }) = ParentRequestsLoaded;
  const factory ParentRequestsState.error(ApiErrorModel error) =
      ParentRequestsError;
}
