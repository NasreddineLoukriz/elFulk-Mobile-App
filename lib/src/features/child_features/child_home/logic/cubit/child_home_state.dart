part of 'child_home_cubit.dart';

@freezed
class ChildHomeState with _$ChildHomeState {
  const factory ChildHomeState.initial() = _Initial;
  const factory ChildHomeState.loading() = ChildHomeLoading;
  const factory ChildHomeState.loaded(ChildHomeOverviewViewModel overview) =
      ChildHomeLoaded;
  const factory ChildHomeState.error(ApiErrorModel error) = ChildHomeError;
}
