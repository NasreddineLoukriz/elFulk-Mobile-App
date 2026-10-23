import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// نص خطأ موحّد يظهر أسفل أزرار النماذج (لون الخطأ من الثيم).
class FormErrorText extends StatelessWidget {
  const FormErrorText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: context.spacing.sm.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: context.spacing.md.r,
            color: theme.colorScheme.error,
          ),
          SizedBox(width: context.spacing.xs.w),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
