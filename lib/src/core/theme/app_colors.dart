import 'package:flutter/material.dart';

/// Semantic color tokens used by both light and dark themes.
///
/// Widgets should read colors from [Theme.of(context).colorScheme] when
/// possible. Use [AppColors] directly only for colors that are not part of
/// the standard Material [ColorScheme], such as subtle background tints or
/// muted text shades.
@immutable
class AppColors {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color scaffoldBackground;
  final Color primary;
  final Color primaryContainer;
  final Color onPrimary;
  final Color text;
  final Color textMuted;
  final Color textLight;
  final Color divider;
  final Color error;
  final Color inputFill;
  final Color inputBorder;
  final Color inputBorderFocused;
  final Color disabled;
  final Color onDisabled;
  final Color socialButtonBorder;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.scaffoldBackground,
    required this.primary,
    required this.primaryContainer,
    required this.onPrimary,
    required this.text,
    required this.textMuted,
    required this.textLight,
    required this.divider,
    required this.error,
    required this.inputFill,
    required this.inputBorder,
    required this.inputBorderFocused,
    required this.disabled,
    required this.onDisabled,
    required this.socialButtonBorder,
  });

  const AppColors.light()
      : background = const Color(0xFFF7F3EC),
        surface = const Color(0xFFF7F1E7),
        surfaceVariant = Colors.white,
        scaffoldBackground = const Color(0xFFF3EEE3),
        primary = const Color(0xFF2E8C84),
        primaryContainer = const Color(0xFF2F857D),
        onPrimary = Colors.white,
        text = const Color(0xFF102221),
        textMuted = const Color(0xFF455452),
        textLight = const Color(0xFF69859D),
        divider = const Color(0xFFE0E0E0),
        error = Colors.red,
        inputFill = Colors.white,
        inputBorder = const Color(0xFFE0E0E0),
        inputBorderFocused = const Color(0xFF2F857D),
        disabled = const Color(0xFFBDBDBD),
        onDisabled = Colors.white,
        socialButtonBorder = const Color(0xFF55B5A6);

  const AppColors.dark()
      : background = const Color(0xFF121212),
        surface = const Color(0xFF1E1E1E),
        surfaceVariant = const Color(0xFF2C2C2C),
        scaffoldBackground = const Color(0xFF121212),
        primary = const Color(0xFF4DB09E),
        primaryContainer = const Color(0xFF2E8C84),
        onPrimary = Colors.white,
        text = const Color(0xFFE0E0E0),
        textMuted = const Color(0xFFB0B0B0),
        textLight = const Color(0xFF90A6BB),
        divider = const Color(0xFF3A3A3A),
        error = const Color(0xFFCF6679),
        inputFill = const Color(0xFF2C2C2C),
        inputBorder = const Color(0xFF3A3A3A),
        inputBorderFocused = const Color(0xFF4DB09E),
        disabled = const Color(0xFF616161),
        onDisabled = Colors.white,
        socialButtonBorder = const Color(0xFF55B5A6);

  /// Returns the appropriate [AppColors] for a Flutter [Brightness].
  factory AppColors.forBrightness(Brightness brightness) {
    return brightness == Brightness.dark
        ? const AppColors.dark()
        : const AppColors.light();
  }
}
