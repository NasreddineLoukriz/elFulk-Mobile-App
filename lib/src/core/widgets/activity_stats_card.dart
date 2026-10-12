import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_dashed_divider.dart';

/// فئة نشاط واحدة (مثال: الفيديوهات / `60% من الوقت`).
class ActivityCategory {
  /// اسم الفئة (مثال: `'الفيديوهات'`).
  final String label;

  /// النسبة المستهلكة (0..1) لشريطها المصغر.
  final double fraction;

  /// نص النسبة المعروض (مثال: `'60% من الوقت'`).
  final String percentLabel;

  /// أيقونة الفئة فوق التسمية (null = بلا أيقونة).
  final IconData? icon;

  const ActivityCategory({
    required this.label,
    required this.fraction,
    required this.percentLabel,
    this.icon,
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

  /// نص زر التقرير (null = بلا زر كما في بطاقة الاستخدام).
  final String? actionLabel;

  /// يُستدعى عند ضغط زر التقرير.
  final VoidCallback? onAction;

  /// أيقونة بداية بجانب العنوان (null = بلا أيقونة).
  final Widget? leadingIcon;

  /// يُستدعى عند ضغط زر التعديل (null = بلا زر).
  final VoidCallback? onEdit;

  /// إظهار فاصل منقط بعد سطر المتبقي (كما في بطاقة الاستخدام).
  final bool showDivider;

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
    this.actionLabel,
    this.onAction,
    this.leadingIcon,
    this.onEdit,
    this.showDivider = false,
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
                if (leadingIcon != null) ...[
                  leadingIcon!,
                  SizedBox(width: context.spacing.sm.w),
                ],
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
                if (onEdit != null) ...[
                  SizedBox(width: context.spacing.sm.w),
                  GestureDetector(
                    key: const ValueKey('activity-stats-edit'),
                    onTap: onEdit,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.edit_outlined,
                          size: 16.sp,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
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
                color:
                    theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            if (showDivider) ...[
              SizedBox(height: context.spacing.sm.h),
              const AppDashedDivider(),
            ],
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
                          if (categories[i].icon != null) ...[
                            Icon(
                              categories[i].icon,
                              size: 20.sp,
                              color: theme.colorScheme.primary,
                            ),
                            SizedBox(height: 2.h),
                          ],
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
            if (actionLabel != null) ...[
              SizedBox(height: context.spacing.md.h),
              _ActionButton(onAction: onAction, actionLabel: actionLabel!),
            ],
          ],
        ),
      ),
    );
  }
}

/// زر التقرير: نص متمركز مع شيفرون أمامي ملاصق (كما في التصميم).
class _ActionButton extends StatelessWidget {
  final VoidCallback? onAction;
  final String actionLabel;

  const _ActionButton({required this.onAction, required this.actionLabel});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return SizedBox(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                actionLabel,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(width: context.spacing.sm.w),
            // ملاحظة: الاتجاه مثبّت على LTR حتى لا ينعكس
            // الشيفرون تلقائياً داخل RTL.
            Icon(
              isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              size: 18.sp,
              textDirection: TextDirection.ltr,
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
