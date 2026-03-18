part of 'architecture_cubit.dart';

@freezed
class ArchitectureState with _$ArchitectureState {
  const factory ArchitectureState.initial() = _Initial;
  const factory ArchitectureState.loading() = ArchitectureLoading;
  const factory ArchitectureState.loaded(
    ArchitectureOverviewViewModel overview,
  ) = ArchitectureLoaded;
  const factory ArchitectureState.error(String message) = ArchitectureError;
}
