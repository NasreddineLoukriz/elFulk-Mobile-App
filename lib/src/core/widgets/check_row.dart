import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// صف checkbox للموافقة على الشروط حسب التصميم (عربي RTL).
///
/// نص قابل للضغط كله يبدّل الحالة + مربع اختيار بلون الرئيسي.
/// يُستخدم في نماذج (تعديل البيانات، التواصل).
class CheckRow extends StatelessWidget {
  /// النص المعروض (مثال: `'أوافق على الشروط والأحكام'`).
  final String label;

  /// الحالة الحالية.
  final bool value;

  /// تُستدعى بالقيمة الجديدة عند التبديل.
  final ValueChanged<bool> onChanged;

  const CheckRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      key: const ValueKey('check-row'),
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.spacing.sm.h),
        child: Row(
          children: [
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: Checkbox(
                value: value,
                onChanged: (bool? v) => onChanged(v ?? false),
                activeColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                side: BorderSide(
                  color: theme.colorScheme.outline,
                  width: 1.5,
                ),
              ),
            ),
            SizedBox(width: context.spacing.sm.w),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
