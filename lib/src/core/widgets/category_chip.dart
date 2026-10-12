import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// شارة تصنيف باستيل حسب التصميم (مثال: `الفضاء والكون ★`).
///
/// خلفية ملوّنة فاتحة ونص بلون أغمق — اللونان بارامتران.
/// تُستخدم في بطاقات المحتوى والتفاصيل.
class CategoryChip extends StatelessWidget {
  /// النص المعروض.
  final String label;

  /// لون الخلفية الفاتح.
  final Color background;

  /// لون النص (افتراضياً نسخة داكنة مشتقة غير متاحة — مرّر صريحاً).
  final Color foreground;

  const CategoryChip({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(context.radius.full.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

/// وسم-بيانات شارة فئة: نص + لون خلفية + لون نص.
class ContentBadge {
  final String label;
  final Color background;
  final Color foreground;

  const ContentBadge({
    required this.label,
    required this.background,
    required this.foreground,
  });
}
