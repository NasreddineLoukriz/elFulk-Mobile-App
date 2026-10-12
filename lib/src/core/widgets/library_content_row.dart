import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// صف محتوى مكتبة (فيديو/قصة) حسب التصميم المرجعي (عربي RTL).
///
/// التخطيط: مصغرة يميناً (بعرض `72.w` مع شارة مدة/تقدم اختيارية)، ثم
/// العمود المتمركز (العنوان + رقاقات الوسوم)، ثم قائمة `⋮` يساراً.
/// الضغط على الصف كله عبر [onTap].
class LibraryContentRow extends StatelessWidget {
  /// المصغرة المعروضة (غلاف/صورة).
  final Widget? thumbnail;

  /// عنوان المحتوى.
  final String title;

  /// وسوم التصنيف (مثال: `['تربية وقيم', 'علوم وتعليم']`).
  final List<String> tags;

  /// شارة فوق المصغرة (مثال: `'15:12'` أو `'4 من 12 فصل'`).
  final String? badge;

  /// عرض المصغرة (افتراضياً `72`).
  final double thumbnailWidth;

  /// ارتفاع المصغرة (افتراضياً `72` — مرّ قيماً أطول لمصغرات القصص).
  final double thumbnailHeight;

  /// يُستدعى عند ضغط الصف.
  final VoidCallback? onTap;

  /// يُستدعى عند ضغط قائمة `⋮` (null = بلا زر).
  final VoidCallback? onMenu;

  const LibraryContentRow({
    super.key,
    this.thumbnail,
    required this.title,
    this.tags = const <String>[],
    this.badge,
    this.thumbnailWidth = 72,
    this.thumbnailHeight = 72,
    this.onTap,
    this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      key: const ValueKey('library-content-row'),
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.spacing.sm.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: thumbnailWidth.w,
                  height: thumbnailHeight.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(context.radius.lg.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: thumbnail,
                ),
                if (badge != null)
                  PositionedDirectional(
                    bottom: 4.h,
                    end: 4.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.75,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        badge!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: context.spacing.sm.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  if (tags.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: context.spacing.xs.w,
                      runSpacing: context.spacing.xs.h,
                      children: [
                        for (final String tag in tags)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.spacing.sm.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(
                                context.radius.full.r,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (onMenu != null) ...[
              SizedBox(width: context.spacing.sm.w),
              GestureDetector(
                key: const ValueKey('library-content-menu'),
                onTap: onMenu,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Icon(
                    Icons.more_vert_rounded,
                    size: 20.sp,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// قسم مكتبة: عنوان + شارة طفل + قائمة صفوف + زر عرض الكل.
class LibrarySection extends StatelessWidget {
  /// عنوان القسم (مثال: `'اضيفة فيديوهات جديدة مقترحة...'`).
  final String title;

  /// اسم الطفل في الشارة (null = بلا شارة).
  final String? childLabel;

  /// صفوف المحتوى.
  final List<LibraryContentRow> rows;

  /// نص زر العرض الكامل (null = بلا زر).
  final String? actionLabel;

  /// يُستدعى عند ضغط زر العرض الكامل.
  final VoidCallback? onAction;

  const LibrarySection({
    super.key,
    required this.title,
    this.childLabel,
    required this.rows,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 14.sp,
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
                  borderRadius: BorderRadius.circular(context.radius.full.r),
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
        for (int i = 0; i < rows.length; i++) ...[
          rows[i],
          if (i < rows.length - 1)
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: theme.colorScheme.outlineVariant,
            ),
        ],
        if (actionLabel != null) ...[
          SizedBox(height: context.spacing.sm.h),
          SizedBox(
            height: 42.h,
            child: ElevatedButton(
              key: const ValueKey('library-section-action'),
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
                      actionLabel!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(width: context.spacing.sm.w),
                  // ملاحظة: الاتجاه مثبّت على LTR حتى لا ينعكس
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
    );
  }
}
