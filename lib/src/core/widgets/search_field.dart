import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// صف البحث حسب التصميم (عربي RTL).
///
/// حقل بحث ممتد (أيقونة عدسة يميناً) + زر فلاتر مربع يساراً.
/// الـ controller يملكه المستدعي.
class SearchField extends StatelessWidget {
  /// تلميح الحقل (مثال: `'هل تبحث عن شيء معين؟'`).
  final String hint;

  /// متحكم النص (يملكه المستدعي ويعدمه).
  final TextEditingController? controller;

  /// تُستدعى عند تغير النص (للفلترة الحية).
  final ValueChanged<String>? onChanged;

  /// يُستدعى عند ضغط زر الفلاتر (null = بلا زر).
  final VoidCallback? onFilter;

  const SearchField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
    this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                filled: true,
                fillColor: theme.cardTheme.color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radius.xxl.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.spacing.md.w,
                ),
              ),
            ),
          ),
        ),
        if (onFilter != null) ...[
          SizedBox(width: context.spacing.sm.w),
          SizedBox(
            width: 48.w,
            height: 48.h,
            child: OutlinedButton(
              key: const ValueKey('search-filter-button'),
              onPressed: onFilter,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.colorScheme.outlineVariant),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radius.xl.r),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 22.sp,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
