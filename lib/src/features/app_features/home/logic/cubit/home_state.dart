part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.loaded(HomeOverviewViewModel overview) = HomeLoaded;
  const factory HomeState.error(ApiErrorModel error) = HomeError;
}
