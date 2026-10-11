import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// حالة فارغة افتراضية للقوائم (لا تصميم لها في الـ mockups).
///
/// أيقونة كبيرة خافتة + عنوان + رسالة توضيحية متمركزة. تُستخدم أينما
/// كانت القائمة فارغة (لا إشعارات، لا أطفال، لا نتائج بحث).
class EmptyState extends StatelessWidget {
  /// الأيقونة المعروضة أعلى النص.
  final IconData icon;

  /// العنوان الرئيسي (مثال: `'لا توجد إشعارات'`).
  final String title;

  /// الرسالة التوضيحية أسفل العنوان.
  final String message;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color muted =
        theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return Padding(
      key: const ValueKey('empty-state'),
      padding: EdgeInsets.all(context.spacing.lg.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48.sp, color: muted),
          SizedBox(height: context.spacing.sm.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ) ??
                TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: context.spacing.xs.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  color: muted,
                ) ??
                TextStyle(fontSize: 13.sp, color: muted),
          ),
        ],
      ),
    );
  }
}
