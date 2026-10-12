import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// فئة الإشعار: تحدد أيقونة شارة الفئة ولونها الافتراضي.
///
/// الألوان الافتراضية مستمدة من الثيم حيث أمكن (`alerts` أحمر الخطأ،
/// `security`/`content`... إلخ) باستثناء لوني الوقت (كهرماني) والمحتوى
/// (أخضر) فهما ثابتا العلامة — ويمكن تجاوز أي لون عبر
/// [NotificationCard.categoryColor].
enum NotificationCategory {
  /// تنبيهات حرجة (أحمر).
  alerts,

  /// تنبيهات الوقت (كهرماني).
  time,

  /// المحتوى المقترح (أخضر).
  content,

  /// الأمان (بلون الرئيسي).
  security,

  /// النظام (رمادي).
  system;

  /// أيقونة شارة الفئة.
  IconData get icon => switch (this) {
    NotificationCategory.alerts => Icons.warning_amber_rounded,
    NotificationCategory.time => Icons.access_time_rounded,
    NotificationCategory.content => Icons.check_circle_outline_rounded,
    NotificationCategory.security => Icons.shield_outlined,
    NotificationCategory.system => Icons.settings_outlined,
  };
}

/// بطاقة إشعار بعرض كامل بتصميم التصميم المرجعي (عربي RTL).
///
/// التخطيط من الأعلى: صف علوي (شارة الفئة يميناً + زر `X` يساراً)، ثم
/// العنوان العريض، ثم النص الخافت، ثم زرّان متجاوران: أساسي مصمت
/// (يمين) بلون الرئيسي مع شيفرون أمامي، وثانوي ملوّن بلون فاتح.
/// شارة اسم الطفل اختيارية (`childLabel` فارغ = نسخة الطفل الواحد).
/// كل النصوص والألوان بارامترات — لا شيء ثابت إلا ألوان الفئات
/// الافتراضية القابلة للتجاوز.
class NotificationCard extends StatelessWidget {
  /// اسم الطفل المعروض في شارة علوية (null = بلا شارة).
  final String? childLabel;

  /// فئة الإشعار (للأيقونة واللون الافتراضيين).
  final NotificationCategory category;

  /// نص شارة الفئة (مثال: `'التنبيهات'`).
  final String categoryLabel;

  /// تجاوز لون الفئة (أيقونة الشارة ونصها).
  final Color? categoryColor;

  /// عنوان البطاقة العريض.
  final String title;

  /// النص التوضيحي الخافت.
  final String body;

  /// نص الزر الأساسي (مثال: `'قفل الجهاز فوراً'`).
  final String primaryLabel;

  /// يُستدعى عند ضغط الزر الأساسي (null = معطّل).
  final VoidCallback? onPrimary;

  /// نص الزر الثانوي (null = زر واحد فقط).
  final String? secondaryLabel;

  /// يُستدعى عند ضغط الزر الثانوي.
  final VoidCallback? onSecondary;

  /// إظهار شيفرون أمامي في الزر الثانوي (الأساسي يعرضه دائماً).
  final bool showSecondaryChevron;

  /// يُستدعى عند ضغط `X` (null = بلا زر إغلاق).
  final VoidCallback? onDismiss;

  /// لون خلفية البطاقة (افتراضياً لون البطاقة من الثيم).
  final Color? backgroundColor;

  const NotificationCard({
    super.key,
    this.childLabel,
    this.category = NotificationCategory.alerts,
    required this.categoryLabel,
    this.categoryColor,
    required this.title,
    required this.body,
    required this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.showSecondaryChevron = false,
    this.onDismiss,
    this.backgroundColor,
  });

  Color _categoryColor(ThemeData theme) {
    if (categoryColor != null) return categoryColor!;
    return switch (category) {
      NotificationCategory.alerts => theme.colorScheme.error,
      NotificationCategory.time => const Color(0xFFF9A825),
      NotificationCategory.content => const Color(0xFF43A047),
      NotificationCategory.security => theme.colorScheme.primary,
      NotificationCategory.system => theme.colorScheme.outline,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color catColor = _categoryColor(theme);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Material(
      color: backgroundColor ?? theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.xxl.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.md.w,
          vertical: context.spacing.md.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.sm.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: catColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(context.radius.full.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(category.icon, size: 14.sp, color: catColor),
                      SizedBox(width: 4.w),
                      Text(
                        categoryLabel,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: catColor,
                        ),
                      ),
                    ],
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
                const Spacer(),
                if (onDismiss != null)
                  GestureDetector(
                    key: const ValueKey('notification-dismiss'),
                    onTap: onDismiss,
                    child: Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close_rounded,
                          size: 16.sp,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: context.spacing.sm.h),
            Text(
              title,
              key: const ValueKey('notification-title'),
              textAlign: TextAlign.start,
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
            SizedBox(height: 4.h),
            Text(
              body,
              key: const ValueKey('notification-body'),
              textAlign: TextAlign.start,
              style:
                  theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ) ??
                  TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
            ),
            SizedBox(height: context.spacing.md.h),
            Row(
              children: [
                Expanded(
                  child: _CardButton(
                    label: primaryLabel,
                    onPressed: onPrimary,
                    background: theme.colorScheme.primary,
                    foreground: theme.colorScheme.onPrimary,
                    showChevron: true,
                    isRtl: isRtl,
                    buttonKey: const ValueKey('notification-primary'),
                  ),
                ),
                if (secondaryLabel != null) ...[
                  SizedBox(width: context.spacing.sm.w),
                  Expanded(
                    child: _CardButton(
                      label: secondaryLabel!,
                      onPressed: onSecondary,
                      background: theme.colorScheme.primary.withValues(
                        alpha: 0.1,
                      ),
                      foreground: theme.colorScheme.primary,
                      showChevron: showSecondaryChevron,
                      isRtl: isRtl,
                      buttonKey: const ValueKey('notification-secondary'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// زر بطاقة الإشعار: نص متمركز مع شيفرون أمامي اختياري عند النهاية.
class _CardButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color background;
  final Color foreground;
  final bool showChevron;
  final bool isRtl;
  final ValueKey<String> buttonKey;

  const _CardButton({
    required this.label,
    required this.onPressed,
    required this.background,
    required this.foreground,
    required this.showChevron,
    required this.isRtl,
    required this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ElevatedButton(
        key: buttonKey,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radius.xxl.r),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: foreground,
              ),
            ),
            if (showChevron)
              // ملاحظة: الاتجاه مثبّت على LTR حتى لا ينعكس الشيفرون
              // تلقائياً (matchTextDirection=true) داخل RTL.
              // الإزاحة 12 تطابق التصميم (بعيداً عن الحافة).
              PositionedDirectional(
                end: 12.w,
                child: Icon(
                  isRtl
                      ? Icons.chevron_left_rounded
                      : Icons.chevron_right_rounded,
                  size: 18.sp,
                  color: foreground,
                  textDirection: TextDirection.ltr,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
