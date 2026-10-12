import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/features/parent_features/profile/data/help_content.dart';

/// الأسئلة الشائعة حسب التصميم (عربي RTL).
///
/// قائمة توسعية (ExpansionTile) من `HelpContent.faq`. الأداء: عناصر
/// قليلة ثابتة فلا حاجة لـ builder.
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar:
          AppBar(title: const Text('الأسئلة الشائعة'), centerTitle: true),
      body: SafeArea(
        child: ListView.separated(
          padding: context.spacing.pagePadding,
          itemCount: HelpContent.faq.length,
          separatorBuilder: (context, _) =>
              SizedBox(height: context.spacing.sm.h),
          itemBuilder: (context, index) {
            final FaqItem item = HelpContent.faq[index];
            return Material(
              color: theme.cardTheme.color,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(context.radius.xl.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: ExpansionTile(
                key: ValueKey('faq-item-$index'),
                title: Text(
                  item.question,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                trailing: Icon(
                  Icons.expand_more_rounded,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.5),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.spacing.md.w,
                      0,
                      context.spacing.md.w,
                      context.spacing.md.h,
                    ),
                    child: Text(
                      item.answer,
                      style: TextStyle(
                        fontSize: 13.sp,
                        height: 1.7,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
