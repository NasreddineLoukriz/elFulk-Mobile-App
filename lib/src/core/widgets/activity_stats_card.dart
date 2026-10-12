import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// فئة نشاط واحدة (مثال: الفيديوهات / `60% من الوقت`).
class ActivityCategory {
  /// اسم الفئة (مثال: `'الفيديوهات'`).
  final String label;

  /// النسبة المستهلكة (0..1) لشريطها المصغر.
  final double fraction;

  /// نص النسبة المعروض (مثال: `'60% من الوقت'`).
  final String percentLabel;

  const ActivityCategory({
    required this.label,
    required this.fraction,
    required this.percentLabel,
  });
}

/// بطاقة إحصائيات النشاط حسب التصميم المرجعي (عربي RTL).
///
/// التخطيط: صف علوي (شارة الطفل + العنوان)، سطرا المسموح/المتبقي،
/// شريط تقدم رئيسي مع تسميتي الطرفين، ثم صفوف الفئات بأشرطة مصغرة،
/// ثم زر عريض بلون الرئيسي. كل القيم بارامترات.
class ActivityStatsCard extends StatelessWidget {
  /// اسم الطفل في الشارة العلوية (null = بلا شارة).
  final String? childLabel;

  /// عنوان البطاقة (مثال: `'بعض بيانات النشاط داخل المنصة بأطفالك'`).
  final String title;

  /// سطر المدة المسموحة (مثال: `'المدة المسموح بها: 2 ساعات و 30 دقيقة.'`).
  final String allowedLine;

  /// سطر المتبقي (مثال: `'الوقت المتبقي من المدة المسموح بها هو: 27 دقيقة.'`).
  final String remainingLine;

  /// نسبة الشريط الرئيسي (0..1).
  final double progress;

  /// تسمية بداية الشريط (مثال: `'0% من الوقت'`).
  final String progressStartLabel;

  /// تسمية نهاية الشريط (مثال: `'100% من الوقت'`).
  final String progressEndLabel;

  /// فئات النشاط الفرعية بأشرطتها المصغرة.
  final List<ActivityCategory> categories;

  /// نص زر التقرير (مثال: `'عرض تقرير النشاط كامل'`).
  final String actionLabel;

  /// يُستدعى عند ضغط زر التقرير.
  final VoidCallback? onAction;

  /// لون خلفية البطاقة (افتراضياً لون البطاقة من الثيم).
  final Color? backgroundColor;

  const ActivityStatsCard({
    super.key,
    this.childLabel,
    required this.title,
    required this.allowedLine,
    required this.remainingLine,
    required this.progress,
    required this.progressStartLabel,
    required this.progressEndLabel,
    this.categories = const <ActivityCategory>[],
    required this.actionLabel,
    this.onAction,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: backgroundColor ?? theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.xxl.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    key: const ValueKey('activity-stats-title'),
                    textAlign: TextAlign.end,
                    style:
                        theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ) ??
                        TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                  ),
                ),
                if (childLabel != null) ...[
                  SizedBox(width: context.spacing.sm.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.sm.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(
                        context.radius.full.r,
                      ),
                    ),
                    child: Text(
                      childLabel!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: context.spacing.sm.h),
            Text(
              allowedLine,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13.sp,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              remainingLine,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13.sp,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: context.spacing.sm.h),
            _ProgressBar(fraction: progress, height: 10.h),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  progressStartLabel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  progressEndLabel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            if (categories.isNotEmpty) ...[
              SizedBox(height: context.spacing.sm.h),
              Row(
                children: [
                  for (int i = 0; i < categories.length; i++) ...[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            categories[i].label,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          _ProgressBar(
                            fraction: categories[i].fraction,
                            height: 6.h,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            categories[i].percentLabel,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i < categories.length - 1)
                      SizedBox(width: context.spacing.sm.w),
                  ],
                ],
              ),
            ],
            SizedBox(height: context.spacing.md.h),
            SizedBox(
              height: 42.h,
              child: ElevatedButton(
                key: const ValueKey('activity-stats-action'),
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxl.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  actionLabel,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// شريط تقدم خطي مستدير: مملوء بلون الرئيسي على مسار فاتح.
class _ProgressBar extends StatelessWidget {
  final double fraction;
  final double height;

  const _ProgressBar({required this.fraction, required this.height});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double clamped = fraction.clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(context.radius.full.r),
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              width: constraints.maxWidth * clamped,
              height: height,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(context.radius.full.r),
              ),
            ),
          ),
        );
      },
    );
  }
}
