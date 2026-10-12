import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// شاشة نصية ثابتة (من نحن / سياسة الخصوصية).
///
/// عنوان AppBar + نص قابل للتمرير. المحتوى placeholder عربي من
/// `HelpContent` حتى توفر النسخ القانونية النهائية.
class StaticInfoScreen extends StatelessWidget {
  final String title;
  final String body;

  const StaticInfoScreen({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            Text(
              body,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.8,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
