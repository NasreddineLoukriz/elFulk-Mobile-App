import 'package:elfulk/src/core/constants/app_breakpoint.dart';
import 'package:flutter/material.dart';

class AppSpacing {
  final double xs;
  final double s;
  final double sm;
  final double m;
  final double md;
  final double sm12;
  final double l;
  final double lg;
  final double xl;

  const AppSpacing({
    required this.xs,
    required this.s,
    required this.sm,
    required this.sm12,
    required this.m,
    required this.md,
    required this.l,
    required this.lg,
    required this.xl,
  });
  EdgeInsets get pagePadding => EdgeInsets.all(l);
  static AppSpacing of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // TABLET / LARGE SCREENS
    if (width >= AppBreakpoints.tablet) {
      return const AppSpacing(
        xs: 8,
        s: 10,
        sm: 12,
        sm12: 20,
        m: 16,
        md: 20,
        l: 24,
        lg: 32,
        xl: 48,
      );
    }

    // MOBILE
    return const AppSpacing(
      xs: 4,
      s: 6,
      sm: 8,
      m: 10,
      sm12: 12,
      md: 16,
      l: 20,
      lg: 24,
      xl: 32,
    );
  }
}
