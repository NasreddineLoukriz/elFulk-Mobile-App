import 'dart:ui' show PathMetric, PathMetrics;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// إحصائية واحدة في صف إحصائيات بطاقة الطفل (مثال: العمر / `08 سنوات`).
class ChildStat {
  /// التسمية العلوية الخافتة (مثال: `'العمر'`).
  final String label;

  /// القيمة الملونة (مثال: `'08 سنوات'`).
  final String value;

  /// لون القيمة (افتراضياً لون السطح `onSurface`).
  final Color? valueColor;

  const ChildStat({required this.label, required this.value, this.valueColor});
}

/// بطاقة طفل بعرض كامل حسب التصميم المرجعي (عربي RTL).
///
/// التخطيط: صف علوي (قائمة `⋮` يساراً + الاسم عريضاً + الصورة يميناً)،
/// ثم سطر المدة (بادئة خافتة + قيمة بلون مميز)، ثم صف إحصائيات بفواصل
/// شعرية، ثم زر عريض بلون الرئيسي مع شيفرون أمامي. الصورة الرمزية
/// widget حر، وافتراضياً دائرة متدرجة وردية بالحرف الأول من الاسم.
class ChildCard extends StatelessWidget {
  /// اسم الطفل (عنوان البطاقة).
  final String name;

  /// الصورة الرمزية (null = دائرة متدرجة بالحرف الأول).
  final Widget? avatar;

  /// بادئة سطر المدة الخافتة (مثال: `'مدة الاستخدام اليوم:'`).
  final String usagePrefix;

  /// قيمة المدة المميزة (مثال: `'2 ساعات و 10 دقائق.'`).
  final String usageValue;

  /// لون قيمة المدة (افتراضياً الرئيسي).
  final Color? usageValueColor;

  /// الإحصائيات الثلاث (تُعرض بفواصل بينها).
  final List<ChildStat> stats;

  /// نص زر الإجراء (مثال: `'الانتقال إلى وجهته الخاصة'`).
  final String actionLabel;

  /// يُستدعى عند ضغط زر الإجراء.
  final VoidCallback? onAction;

  /// يُستدعى عند ضغط قائمة `⋮` (null = بلا زر قائمة).
  final VoidCallback? onMenu;

  /// لون خلفية البطاقة (افتراضياً لون البطاقة من الثيم).
  final Color? backgroundColor;

  const ChildCard({
    super.key,
    required this.name,
    this.avatar,
    required this.usagePrefix,
    required this.usageValue,
    this.usageValueColor,
    this.stats = const <ChildStat>[],
    required this.actionLabel,
    this.onAction,
    this.onMenu,
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
                SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: avatar ?? _DefaultAvatar(name: name),
                ),
                SizedBox(width: context.spacing.sm.w),
                Expanded(
                  child: Text(
                    name,
                    key: const ValueKey('child-card-name'),
                    textAlign: TextAlign.end,
                    style:
                        theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ) ??
                        TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                  ),
                ),
                if (onMenu != null) ...[
                  SizedBox(width: context.spacing.sm.w),
                  GestureDetector(
                    key: const ValueKey('child-card-menu'),
                    onTap: onMenu,
                    child: Icon(
                      Icons.more_vert_rounded,
                      size: 20.sp,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 4.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$usagePrefix ',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  TextSpan(
                    text: usageValue,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: usageValueColor ?? theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              key: const ValueKey('child-card-usage'),
              textAlign: TextAlign.end,
            ),
            if (stats.isNotEmpty) ...[
              SizedBox(height: context.spacing.sm.h),
              Row(
                children: [
                  for (int i = 0; i < stats.length; i++) ...[
                    Expanded(child: _StatCell(stat: stats[i])),
                    if (i < stats.length - 1)
                      Container(
                        width: 1.w,
                        height: 32.h,
                        color: theme.colorScheme.outlineVariant,
                      ),
                  ],
                ],
              ),
            ],
            SizedBox(height: context.spacing.md.h),
            SizedBox(
              height: 42.h,
              child: ElevatedButton(
                key: const ValueKey('child-card-action'),
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
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: context.spacing.sm.w),
                    // ملاحظة: الاتجاه مثبّت على LTR حتى لا ينعكس
                    // الشيفرون تلقائياً داخل RTL.
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Icons.chevron_left_rounded
                          : Icons.chevron_right_rounded,
                      size: 18.sp,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// خلية إحصائية واحدة (تسمية خافتة فوق قيمة ملوّنة).
class _StatCell extends StatelessWidget {
  final ChildStat stat;

  const _StatCell({required this.stat});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          stat.label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          stat.value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: stat.valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

/// الأفاتار الافتراضي: دائرة متدرجة وردية (كما في التصميم) بالحرف الأول.
class _DefaultAvatar extends StatelessWidget {
  final String name;

  const _DefaultAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    final String first = name.characters.isEmpty ? '' : name.characters.first;

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFEBA5AC), Color(0xFFE93C6E)],
        ),
      ),
      child: Center(
        child: Text(
          first,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// بطاقة منقطة لإضافة طفل جديد حسب التصميم.
///
/// حد منقط بلون الرئيسي + أيقونة إضافة + نص. الضغط كامل البطاقة.
class AddChildDashedCard extends StatelessWidget {
  /// النص المعروض (مثال: `'إضافة طفل جديد'`).
  final String label;

  /// يُستدعى عند الضغط.
  final VoidCallback? onTap;

  const AddChildDashedCard({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      key: const ValueKey('add-child-dashed-card'),
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: theme.colorScheme.primary,
          radius: context.radius.xxl.r,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: context.spacing.lg.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person_add_outlined,
                size: 28.sp,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: context.spacing.sm.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// رسّام حد منقط بزوايا مستديرة (لا حزمة خارجية له في المشروع).
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  const _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 6;
    const double dashGap = 4;
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final Path path = Path()..addRRect(rrect);
    final PathMetrics metrics = path.computeMetrics();
    for (final PathMetric metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final double end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
