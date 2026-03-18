import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData buildAppTheme() {
  const Color seedColor = Color(0xFF0F766E);
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
    surface: const Color(0xFFF7F1E7),
  );

  final ThemeData baseTheme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
  );

  return baseTheme.copyWith(
    scaffoldBackgroundColor: const Color(0xFFF3EEE3),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: const Color(0xFF102221),
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
    ),
    textTheme: baseTheme.textTheme.copyWith(
      displaySmall: baseTheme.textTheme.displaySmall?.copyWith(
        fontSize: 36.sp,
        color: const Color(0xFF102221),
        fontWeight: FontWeight.w800,
      ),
      headlineLarge: baseTheme.textTheme.headlineLarge?.copyWith(
        fontSize: 32.sp,
        color: const Color(0xFF102221),
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(
        fontSize: 28.sp,
        color: const Color(0xFF102221),
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(
        fontSize: 24.sp,
        color: const Color(0xFF102221),
        fontWeight: FontWeight.w800,
      ),
      titleLarge: baseTheme.textTheme.titleLarge?.copyWith(
        fontSize: 20.sp,
        color: const Color(0xFF102221),
        fontWeight: FontWeight.w700,
      ),
      titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
        fontSize: 18.sp,
        color: const Color(0xFF102221),
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(
        fontSize: 16.sp,
        color: const Color(0xFF334140),
        height: 1.45,
      ),
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
        fontSize: 14.sp,
        color: const Color(0xFF455452),
        height: 1.5,
      ),
      bodySmall: baseTheme.textTheme.bodySmall?.copyWith(
        fontSize: 12.sp,
        color: const Color(0xFF455452),
      ),
      labelLarge: baseTheme.textTheme.labelLarge?.copyWith(fontSize: 14.sp),
      labelMedium: baseTheme.textTheme.labelMedium?.copyWith(fontSize: 12.sp),
    ),
  );
}
