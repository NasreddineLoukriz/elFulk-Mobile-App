part of 'home_dashboard_cubit.dart';

// ملاحظة: makeCollectionsUnmodifiable=false لأن مولّد freezed يُخرج
// `required final` لمعاملات القوائم وهو ما يرفضه المحلل الحالي.
@Freezed(makeCollectionsUnmodifiable: false)
class HomeDashboardState with _$HomeDashboardState {
  const factory HomeDashboardState.initial() = _Initial;
  const factory HomeDashboardState.loading() = HomeDashboardLoading;
  const factory HomeDashboardState.loaded(HomeDashboard dashboard) =
      HomeDashboardLoaded;
  const factory HomeDashboardState.error(ApiErrorModel error) =
      HomeDashboardError;
}
