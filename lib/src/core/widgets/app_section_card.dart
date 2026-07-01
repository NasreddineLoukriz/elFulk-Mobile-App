import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    required this.title,
    required this.child,
    this.eyebrow,
    this.accentColor,
    super.key,
  });

  final String title;
  final String? eyebrow;
  final Widget child;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color borderColor = accentColor ?? theme.colorScheme.outlineVariant;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: borderColor.withValues(alpha: 0.32)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.08),
            blurRadius: 28.r,
            offset: Offset(0, 14.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (eyebrow != null) ...<Widget>[
            Text(
              eyebrow!.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: borderColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1.w,
              ),
            ),
            verticalSpace(8),
          ],
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          verticalSpace(16),
          child,
        ],
      ),
    );
  }
}
