import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// عنوان قسم خافت بمحاذاة البداية مع إجراء اختياري في النهاية.
///
/// يُستخدم فوق بطاقات الأقسام (مثال: `كل الإشعارات`) في صفحات الإعدادات
/// والقوائم. النص خافت (`onSurface` بشفافية 60%) حسب التصميم المرجعي.
class SectionHeader extends StatelessWidget {
  /// نص العنوان (مثال: `'تخصيص الإشعارات'`).
  final String title;

  /// إجراء اختياري في نهاية الصف (مثال: زر `عرض الكل`).
  final Widget? action;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      key: const ValueKey('section-header'),
      padding: EdgeInsets.symmetric(horizontal: context.spacing.md.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ) ??
                  TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
