import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/constants/app_raduis.dart';
import 'package:elfulk/src/core/theme/app_colors.dart';

ThemeData buildLightTheme() => _buildTheme(const AppColors.light());

ThemeData buildDarkTheme() => _buildTheme(const AppColors.dark());

ThemeData _buildTheme(AppColors colors) {
  const AppRadius radius = AppRadius();
  final Brightness brightness =
      colors.scaffoldBackground.computeLuminance() > 0.5
          ? Brightness.light
          : Brightness.dark;

  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: colors.primary,
    brightness: brightness,
    surface: colors.surface,
    primary: colors.primary,
    onPrimary: colors.onPrimary,
    error: colors.error,
  );

  final ThemeData baseTheme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: brightness,
  );

  return baseTheme.copyWith(
    scaffoldBackgroundColor: colors.scaffoldBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: colors.surface,
      foregroundColor: colors.text,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: colors.surfaceVariant,
      elevation: 0,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.x4l.r),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.inputFill,
      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.xl.r),
        borderSide: BorderSide(color: colors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.xl.r),
        borderSide: BorderSide(color: colors.inputBorderFocused),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.xl.r),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius.xl.r),
        borderSide: BorderSide(color: colors.error),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        disabledBackgroundColor: colors.disabled,
        disabledForegroundColor: colors.onDisabled,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.xxl.r),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: colors.socialButtonBorder, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.xxl.r),
        ),
      ),
    ),
    textTheme: baseTheme.textTheme.copyWith(
      displaySmall: baseTheme.textTheme.displaySmall?.copyWith(
        fontSize: 36.sp,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      headlineLarge: baseTheme.textTheme.headlineLarge?.copyWith(
        fontSize: 32.sp,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(
        fontSize: 28.sp,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(
        fontSize: 24.sp,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      titleLarge: baseTheme.textTheme.titleLarge?.copyWith(
        fontSize: 20.sp,
        color: colors.text,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
        fontSize: 18.sp,
        color: colors.text,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(
        fontSize: 16.sp,
        color: colors.textMuted,
        height: 1.45,
      ),
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
        fontSize: 14.sp,
        color: colors.textMuted,
        height: 1.5,
      ),
      bodySmall: baseTheme.textTheme.bodySmall?.copyWith(
        fontSize: 12.sp,
        color: colors.textMuted,
      ),
      labelLarge: baseTheme.textTheme.labelLarge?.copyWith(fontSize: 14.sp),
      labelMedium: baseTheme.textTheme.labelMedium?.copyWith(fontSize: 12.sp),
    ),
  );
}
