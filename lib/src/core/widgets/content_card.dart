import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/category_chip.dart';

/// بطاقة محتوى كبيرة حسب التصميم (عربي RTL).
///
/// فن علوي بعرض كامل + جسم (عنوان متمركز + شارات + قائمة ⋮ على
/// الطرف) + زر CTA سفلي بعرض كامل. تُستخدم في المكتبة للألعاب
/// والفيديوهات والقصص ببارامترات فقط.
class ContentCard extends StatelessWidget {
  /// العمل الفني العلوي (صورة/رسم).
  final Widget? art;

  /// ارتفاع منطقة الفن.
  final double artHeight;

  /// عنوان البطاقة المتمركز.
  final String title;

  /// شارات التصنيف تحت العنوان.
  final List<ContentBadge> badges;

  /// نص زر الإجراء (null = بلا زر).
  final String? actionLabel;

  /// يُستدعى عند ضغط الزر.
  final VoidCallback? onAction;

  /// يُستدعى عند ضغط قائمة `⋮` (null = بلا زر).
  final VoidCallback? onMenu;

  /// لون خلفية البطاقة (افتراضياً لون البطاقة من الثيم).
  final Color? backgroundColor;

  const ContentCard({
    super.key,
    this.art,
    this.artHeight = 180,
    required this.title,
    this.badges = const <ContentBadge>[],
    this.actionLabel,
    this.onAction,
    this.onMenu,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Material(
      color: backgroundColor ?? theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.xxl.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (art != null)
            SizedBox(height: artHeight.h, width: double.infinity, child: art),
          Padding(
            padding: EdgeInsets.all(context.spacing.md.r),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      key: const ValueKey('content-card-title'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
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
                    if (actionLabel != null) ...[
                      SizedBox(height: context.spacing.md.h),
                      SizedBox(
                        height: 42.h,
                        child: ElevatedButton(
                          key: const ValueKey('content-card-action'),
                          onPressed: onAction,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.radius.xxl.r,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  actionLabel!,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(width: context.spacing.sm.w),
                              // الاتجاه مثبّت على LTR حتى لا ينعكس
                              // الشيفرون تلقائياً داخل RTL.
                              Icon(
                                isRtl
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
                  ],
                ),
                if (onMenu != null)
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: GestureDetector(
                      key: const ValueKey('content-card-menu'),
                      onTap: onMenu,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.more_vert_rounded,
                          size: 20.sp,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
