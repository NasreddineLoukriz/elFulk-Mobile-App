import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// رقاقة (chip) اختيارية وحيدة الاختيار للفلاتر حسب التصميم.
///
/// المحددة: خلفية `primary` ونص فاتح. غير المحددة: خلفية محايدة ونص
/// داكن. تُستخدم في صفوف الفلاتر الأفقية (مثال: `كل الإشعارات`).
class AppFilterChip extends StatelessWidget {
  /// النص المعروض داخل الرقاقة.
  final String label;

  /// هل الرقاقة محددة حالياً.
  final bool selected;

  /// تُستدعى عند الضغط على الرقاقة.
  final VoidCallback onSelected;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: selected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
      ),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.full.r),
        side: BorderSide.none,
      ),
      showCheckmark: false,
    );
  }
}
