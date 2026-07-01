part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.initial() = _Initial;
  const factory ThemeState.loaded(ThemeMode mode) = _Loaded;
}

extension ThemeStateX on ThemeState {
  ThemeMode get mode => map(
        initial: (_) => ThemeMode.system,
        loaded: (_Loaded state) => state.mode,
      );
}
