import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// شارة عدّاد/وسم صغيرة (مثال: `01`، `16:00`، `جديد`).
///
/// خلفية ملوّنة بشفافية 12% ونص بلونها الكامل. اللون الافتراضي هو
/// الرئيسي `primary`، ويُمرَّر لون مخصص لشارات الفئات
/// (أحمر للتنبيهات، كهرماني للوقت...).
class AppBadge extends StatelessWidget {
  /// النص داخل الشارة.
  final String label;

  /// اللون الأساسي للشارة (خلفية بشفافية + نص كامل).
  ///
  /// الافتراضي: `colorScheme.primary`.
  final Color? color;

  const AppBadge({
    super.key,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color base = color ?? theme.colorScheme.primary;

    return Container(
      key: const ValueKey('app-badge'),
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: base.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.radius.full.r),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: base,
            ) ??
            TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: base,
            ),
      ),
    );
  }
}
