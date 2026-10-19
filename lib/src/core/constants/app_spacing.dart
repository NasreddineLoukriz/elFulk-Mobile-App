import 'package:elfulk/src/core/constants/app_breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// سلّم المسافات المعتمد من فريق التصميم (وحدات 2/4/6/8/...).
///
/// الحقول الأصلية (xs..xl) مستخدمة في الشاشات القائمة؛ الحقول المضافة
/// تغطي القيم الناقصة من سلّم التصميم دون كسر أي استخدام قائم.
class AppSpacing {
  final double xxs;
  final double xs;
  final double s;
  final double sm;
  final double s14;
  final double m;
  final double md;
  final double sm12;
  final double s18;
  final double l;
  final double lg;
  final double s22;
  final double xl;
  final double s28;
  final double xxl;
  final double x3l;
  final double x4l;
  final double x5l;
  final double x6l;
  final double x7l;
  final double x8l;
  final double x9l;

  const AppSpacing({
    required this.xxs,
    required this.xs,
    required this.s,
    required this.sm,
    required this.s14,
    required this.m,
    required this.md,
    required this.sm12,
    required this.s18,
    required this.l,
    required this.lg,
    required this.s22,
    required this.xl,
    required this.s28,
    required this.xxl,
    required this.x3l,
    required this.x4l,
    required this.x5l,
    required this.x6l,
    required this.x7l,
    required this.x8l,
    required this.x9l,
  });
  EdgeInsets get pagePadding => EdgeInsets.all(l.r);
  static AppSpacing of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // TABLET / LARGE SCREENS
    if (width >= AppBreakpoints.tablet) {
      return const AppSpacing(
        xxs: 4,
        xs: 8,
        s: 10,
        sm: 12,
        s14: 20,
        m: 16,
        md: 20,
        sm12: 20,
        s18: 28,
        l: 24,
        lg: 32,
        s22: 32,
        xl: 48,
        s28: 40,
        xxl: 48,
        x3l: 56,
        x4l: 64,
        x5l: 72,
        x6l: 80,
        x7l: 96,
        x8l: 112,
        x9l: 144,
      );
    }

    // MOBILE
    return const AppSpacing(
      xxs: 2,
      xs: 4,
      s: 6,
      sm: 8,
      s14: 14,
      m: 10,
      sm12: 12,
      md: 16,
      s18: 18,
      l: 20,
      lg: 24,
      s22: 22,
      xl: 32,
      s28: 28,
      xxl: 36,
      x3l: 40,
      x4l: 44,
      x5l: 48,
      x6l: 56,
      x7l: 64,
      x8l: 80,
      x9l: 96,
    );
  }
}
