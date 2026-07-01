import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

part 'theme_cubit.freezed.dart';
part 'theme_state.dart';

const String _kThemeModeKey = 'app_theme_mode';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState.initial());

  /// Loads the saved theme mode from preferences.
  /// Falls back to [ThemeMode.system] when nothing is saved.
  Future<void> load() async {
    final String raw = await SharedPrefHelper.getString(_kThemeModeKey);
    final ThemeMode mode = _parse(raw);
    emit(ThemeState.loaded(mode));
  }

  /// Cycles through light → dark → system.
  Future<void> toggle() async {
    final ThemeMode next = switch (state.mode) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    await _set(next);
  }

  /// Sets a specific theme mode and persists it.
  Future<void> setMode(ThemeMode mode) async {
    await _set(mode);
  }

  Future<void> _set(ThemeMode mode) async {
    await SharedPrefHelper.setData(_kThemeModeKey, mode.name);
    emit(ThemeState.loaded(mode));
  }

  ThemeMode _parse(String raw) {
    return ThemeMode.values.firstWhere(
      (ThemeMode mode) => mode.name == raw,
      orElse: () => ThemeMode.system,
    );
  }
}
