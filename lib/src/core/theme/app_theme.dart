import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/constants/app_raduis.dart';
import 'package:elfulk/src/core/theme/app_colors.dart';
import 'package:elfulk/src/core/theme/app_fonts.dart';

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
    fontFamily: AppFonts.parent,
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
      displayLarge: baseTheme.textTheme.displayLarge?.copyWith(
        fontSize: 40.sp,
        height: 1.2,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      displayMedium: baseTheme.textTheme.displayMedium?.copyWith(
        fontSize: 34.sp,
        height: 1.2,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      displaySmall: baseTheme.textTheme.displaySmall?.copyWith(
        fontSize: 28.sp,
        height: 1.25,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      headlineLarge: baseTheme.textTheme.headlineLarge?.copyWith(
        fontSize: 26.sp,
        height: 1.25,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(
        fontSize: 22.sp,
        height: 1.25,
        color: colors.text,
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(
        fontSize: 20.sp,
        height: 1.3,
        color: colors.text,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: baseTheme.textTheme.titleLarge?.copyWith(
        fontSize: 18.sp,
        height: 1.3,
        color: colors.text,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
        fontSize: 16.sp,
        height: 1.35,
        color: colors.text,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: baseTheme.textTheme.titleSmall?.copyWith(
        fontSize: 14.sp,
        height: 1.35,
        color: colors.text,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(
        fontSize: 18.sp,
        height: 24 / 18,
        color: colors.textMuted,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
        fontSize: 16.sp,
        height: 22 / 16,
        color: colors.textMuted,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: baseTheme.textTheme.bodySmall?.copyWith(
        fontSize: 14.sp,
        height: 20 / 14,
        color: colors.textMuted,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: baseTheme.textTheme.labelLarge?.copyWith(
        fontSize: 14.sp,
        height: 18 / 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: baseTheme.textTheme.labelMedium?.copyWith(
        fontSize: 12.sp,
        height: 14 / 12,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: baseTheme.textTheme.labelSmall?.copyWith(
        fontSize: 11.sp,
        height: 14 / 11,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
