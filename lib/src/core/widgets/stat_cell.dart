import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// خلية إحصائية واحدة: تسمية خافتة فوق قيمة ملوّنة.
///
/// تُستخدم في صفوف الإحصائيات (بطاقة الطفل، ترويسة الحساب) بفواصل
/// شعرية بين الخلايا. اللون الافتراضي للقيمة من الثيم.
class StatCell extends StatelessWidget {
  /// التسمية العلوية الخافتة (مثال: `'العمر'`).
  final String label;

  /// القيمة الملونة (مثال: `'08 سنوات'`).
  final String value;

  /// لون القيمة (افتراضياً `onSurface`).
  final Color? valueColor;

  const StatCell({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color:
                theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
