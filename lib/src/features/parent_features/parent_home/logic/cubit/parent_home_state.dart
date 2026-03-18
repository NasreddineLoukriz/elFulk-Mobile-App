part of 'parent_home_cubit.dart';

@freezed
class ParentHomeState with _$ParentHomeState {
  const factory ParentHomeState.initial() = _Initial;
  const factory ParentHomeState.loading() = ParentHomeLoading;
  const factory ParentHomeState.loaded(ParentHomeOverviewViewModel overview) =
      ParentHomeLoaded;
  const factory ParentHomeState.error(ApiErrorModel error) = ParentHomeError;
}
