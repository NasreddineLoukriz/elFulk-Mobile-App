import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// شريط تقدم القارئ المجزأ حسب التصميم (عربي RTL).
///
/// كبسولات أفقية بعدد الفصول، تُملأ من اليمين (البداية في RTL)
/// بعدد `read` منها بلون الرئيسي والباقي بلون خافت.
class ReaderProgress extends StatelessWidget {
  /// عدد الفصول الكلي.
  final int total;

  /// عدد الفصول المقروءة (تُملأ من اليمين).
  final int read;

  const ReaderProgress({super.key, required this.total, required this.read})
    : assert(total > 0, 'total must be positive');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int filled = read.clamp(0, total);

    return Row(
      key: const ValueKey('reader-progress'),
      children: [
        for (int i = 0; i < total; i++)
          Expanded(
            child: Container(
              height: 6.h,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: i < filled
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(context.radius.full.r),
              ),
            ),
          ),
      ],
    );
  }
}

/// زرا تنقل القارئ حسب التصميم (عربي RTL).
///
/// اليمين: زر شاحب (السابق) بشيفرون يمين. اليسار: زر مصمت
/// (التالي) بشيفرون يسار. متساويا العرض.
class ReaderNav extends StatelessWidget {
  /// نص زر السابق (يمين).
  final String prevLabel;

  /// نص زر التالي (يسار).
  final String nextLabel;

  /// هل زر السابق مفعّل.
  final bool prevEnabled;

  /// هل زر التالي مفعّل.
  final bool nextEnabled;

  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const ReaderNav({
    super.key,
    required this.prevLabel,
    required this.nextLabel,
    this.prevEnabled = true,
    this.nextEnabled = true,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    Widget navButton({
      required String label,
      required bool filled,
      required bool enabled,
      required VoidCallback? onPressed,
      required IconData chevron,
      required String keyValue,
    }) {
      final Color bg = filled
          ? theme.colorScheme.primary
          : theme.colorScheme.primary.withValues(alpha: 0.1);
      final Color fg = filled
          ? theme.colorScheme.onPrimary
          : theme.colorScheme.primary;

      return Expanded(
        child: SizedBox(
          height: 48.h,
          child: ElevatedButton(
            key: ValueKey<String>(keyValue),
            onPressed: enabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: bg,
              foregroundColor: fg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.radius.xl.r),
                side: filled
                    ? BorderSide.none
                    : BorderSide(color: theme.colorScheme.primary),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                // الاتجاه مثبّت على LTR حتى لا ينعكس الشيفرون
                // تلقائياً داخل RTL.
                Icon(chevron, size: 18.sp, textDirection: TextDirection.ltr),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        // الأول منطقياً = اليمين في RTL (السابق).
        navButton(
          label: prevLabel,
          filled: false,
          enabled: prevEnabled,
          onPressed: onPrev,
          chevron: isRtl
              ? Icons.chevron_right_rounded
              : Icons.chevron_left_rounded,
          keyValue: 'reader-prev',
        ),
        SizedBox(width: context.spacing.md.w),
        navButton(
          label: nextLabel,
          filled: true,
          enabled: nextEnabled,
          onPressed: onNext,
          chevron: isRtl
              ? Icons.chevron_left_rounded
              : Icons.chevron_right_rounded,
          keyValue: 'reader-next',
        ),
      ],
    );
  }
}
