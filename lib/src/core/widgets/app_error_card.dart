import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// بطاقة خطأ موحدة (لا تصميم لها في الـ mockups).
///
/// أيقونة تحذير + رسالة الخطأ + زر `إعادة المحاولة` اختياري. تُستخدم
/// كبديل بصري موحد لحالات `error` في الـ cubits.
class AppErrorCard extends StatelessWidget {
  /// رسالة الخطأ المعروضة.
  final String message;

  /// يُستدعى عند ضغط زر الإعادة. عند `null` لا يظهر الزر.
  final VoidCallback? onRetry;

  const AppErrorCard({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      key: const ValueKey('app-error-card'),
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(context.radius.xl.r),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 32.sp,
            color: theme.colorScheme.error,
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                ) ??
                TextStyle(fontSize: 14.sp),
          ),
          if (onRetry != null) ...[
            SizedBox(height: context.spacing.sm.h),
            TextButton(
              key: const ValueKey('app-error-retry'),
              onPressed: onRetry,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ],
      ),
    );
  }
}
