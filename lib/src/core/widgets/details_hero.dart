import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/category_chip.dart';

/// ترويسة التفاصيل حسب التصميم (عربي RTL).
///
/// صورة بطولية بعرض كامل + عمل فني متمركز متداخل على حدها السفلي
/// + عنوان + صف شارات. تُستخدم لتفاصيل الألعاب والقصص والفيديوهات.
class DetailsHero extends StatelessWidget {
  /// العمل الفني الخلفي (بانر).
  final Widget? backdrop;

  /// ارتفاع البانر.
  final double backdropHeight;

  /// العمل الفني المتداخل المتمركز (غلاف).
  final Widget? cover;

  /// حجم الغلاف المربع.
  final double coverSize;

  /// مقدار تداخل الغلاف على البانر.
  final double overlap;

  /// العنوان تحت الغلاف.
  final String title;

  /// شارات التصنيف.
  final List<ContentBadge> badges;

  const DetailsHero({
    super.key,
    this.backdrop,
    this.backdropHeight = 200,
    this.cover,
    this.coverSize = 120,
    this.overlap = 60,
    required this.title,
    this.badges = const <ContentBadge>[],
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: backdropHeight.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(context.radius.xxl.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: backdrop,
            ),
            if (cover != null)
              PositionedDirectional(
                bottom: -overlap.h,
                start: 0,
                end: 0,
                child: Center(
                  child: Container(
                    width: coverSize.w,
                    height: coverSize.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.radius.xl.r),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: cover,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: (overlap + context.spacing.md.h).h),
        Text(
          title,
          key: const ValueKey('details-hero-title'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
          ),
        ),
        if (badges.isNotEmpty) ...[
          SizedBox(height: context.spacing.sm.h),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: context.spacing.sm.w,
            runSpacing: context.spacing.xs.h,
            children: [
              for (final ContentBadge badge in badges)
                CategoryChip(
                  label: badge.label,
                  background: badge.background,
                  foreground: badge.foreground,
                ),
            ],
          ),
        ],
      ],
    );
  }
}
