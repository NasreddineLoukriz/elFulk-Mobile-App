import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// زر بعرض كامل بنمط "اسحب للتأكيد" مخصّص للإجراءات الخطيرة
/// غير القابلة للتراجع (حذف الحساب، حذف ملف الطفل، إعادة ضبط المصنع).
///
/// يجب على المستخدم سحب القرص الدائري من بداية المسار إلى نهايته
/// لتأكيد الإجراء. يبقى [label] في المنتصف أثناء حركة القرص. تشير دائرة
/// شبح تحتوي [hintIcon] مع أسهم الاتجاه إلى الوجهة عند نهاية المسار
/// وتتلاشى تدريجياً مع اقتراب القرص. الإفلات قبل [threshold] يعيد القرص
/// بحركة مرنة إلى البداية؛ والإفلات عند [threshold] أو بعده يستدعي
/// [onConfirmed] مرة واحدة مع اهتزاز لمسي متوسط.
///
/// يعكس اتجاه السحب اتجاه [Directionality] المحيط ما لم يتجاوزه
/// [textDirection]: في اللغات LTR يتحرك القرص من اليسار إلى اليمين،
/// وفي اللغات RTL (أو عند فرضه عبر [textDirection]) من اليمين إلى اليسار.
///
/// جميع المقاسات تستخدم `flutter_screenutil` وجميع الألوان الاحتياطية
/// مأخوذة من `Theme.of(context).colorScheme`، فلا توجد أي قيم تصميم
/// ثابتة داخل هذا الـ widget.
class SlideToConfirmButton extends StatefulWidget {
  /// النص المعروض في منتصف المسار (مثال: `'حذف حسابي'`).
  final String label;

  /// يُستدعى مرة واحدة فقط عند إكمال المستخدم للسحب.
  final VoidCallback onConfirmed;

  /// الـ widget المعروض داخل قرص البداية المصمت.
  ///
  /// الافتراضي: أيقونة سلة مهملات بلون [thumbIconColor].
  final Widget? thumbIcon;

  /// الـ widget المعروض داخل دائرة الوجهة الشبح عند نهاية المسار
  /// بجانب أسهم الاتجاه.
  ///
  /// الافتراضي: أيقونة سلة مهملات بلون [progressColor].
  final Widget? hintIcon;

  /// لون خلفية المسار غير المملوء.
  ///
  /// الافتراضي: [progressColor] بشفافية 8% (مسار ملوّن بلون فاتح).
  final Color? trackColor;

  /// لون التقدم المملوء خلف القرص، ولون القرص نفسه (ما لم يُمرَّر
  /// [thumbColor])، ولون الأسهم ولون [label] المتمركز (ما لم يُمرَّر
  /// [labelColor]).
  ///
  /// الافتراضي: `colorScheme.error` (الأحمر التحذيري).
  final Color? progressColor;

  /// لون خلفية القرص الدائري.
  ///
  /// الافتراضي: [progressColor] (أو `colorScheme.error`).
  final Color? thumbColor;

  /// لون الأيقونة داخل القرص.
  ///
  /// الافتراضي: `colorScheme.onError`.
  final Color? thumbIconColor;

  /// لون [label] المتمركز.
  ///
  /// الافتراضي: [progressColor] (أو `colorScheme.error`).
  final Color? labelColor;

  /// لون خلفية دائرة الوجهة الشبح.
  ///
  /// الافتراضي: [progressColor] بشفافية 25%.
  final Color? ghostColor;

  /// نسبة المسار التي يجب أن يتجاوزها القرص للتأكيد (0..1].
  ///
  /// الافتراضي: `0.9` (يتجاوز مركز القرص 90% من عرض المسار).
  final double threshold;

  /// هل يستجيب الزر لإيماءات السحب.
  ///
  /// الافتراضي: `true`.
  final bool enabled;

  /// يتجاوز اتجاه [Directionality] المحيط لمسار السحب.
  ///
  /// عند `null` (الافتراضي) يتبع السحب الاتجاه المحيط. مرّر
  /// `TextDirection.rtl` لفرض سحب من اليمين إلى اليسار (مثال: نص عربي
  /// معروض بينما يعمل التطبيق باتجاه LTR محيط).
  final TextDirection? textDirection;

  const SlideToConfirmButton({
    super.key,
    required this.label,
    required this.onConfirmed,
    this.thumbIcon,
    this.hintIcon,
    this.trackColor,
    this.progressColor,
    this.thumbColor,
    this.thumbIconColor,
    this.labelColor,
    this.ghostColor,
    this.threshold = 0.9,
    this.enabled = true,
    this.textDirection,
  });

  @override
  State<SlideToConfirmButton> createState() => _SlideToConfirmButtonState();
}

class _SlideToConfirmButtonState extends State<SlideToConfirmButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _snapBackController;
  double _dragOffset = 0;
  bool _confirmed = false;

  @override
  void initState() {
    super.initState();
    _snapBackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(_onSnapBackTick);
  }

  @override
  void dispose() {
    _snapBackController
      ..removeListener(_onSnapBackTick)
      ..dispose();
    super.dispose();
  }

  double _snapFrom = 0;

  void _onSnapBackTick() {
    setState(() {
      _dragOffset =
          _snapFrom * (1 - Curves.easeOut.transform(_snapBackController.value));
    });
  }

  void _animateBackToStart() {
    _snapFrom = _dragOffset;
    _snapBackController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextDirection effectiveDirection =
        widget.textDirection ?? Directionality.of(context);
    final bool isRtl =
        effectiveDirection == TextDirection.rtl;

    final Color progress =
        widget.progressColor ?? theme.colorScheme.error;
    final Color track =
        widget.trackColor ?? progress.withValues(alpha: 0.08);
    final Color thumb = widget.thumbColor ?? progress;
    final Color thumbIconColor =
        widget.thumbIconColor ?? theme.colorScheme.onError;
    final Color ghost =
        widget.ghostColor ?? progress.withValues(alpha: 0.25);
    final IconData chevronIcon = isRtl
        ? Icons.chevron_left_rounded
        : Icons.chevron_right_rounded;

    final Widget thumbIconWidget = widget.thumbIcon ??
        Icon(
          Icons.delete_outline_rounded,
          size: 20.sp,
          color: thumbIconColor,
        );
    final Widget hintIconWidget = widget.hintIcon ??
        Icon(
          Icons.delete_outline_rounded,
          size: 20.sp,
          color: progress,
        );

    final double trackHeight = 42.h;
    final double thumbSize = trackHeight - 6.h;
    final double edgePadding = 3.h;

    return Directionality(
      textDirection: effectiveDirection,
      child: LayoutBuilder(
        builder: (context, constraints) {
        final double maxSlide =
            (constraints.maxWidth - thumbSize - edgePadding * 2)
                .clamp(0.0, double.infinity);
        final double rawCompletion =
            maxSlide <= 0 ? 0 : _dragOffset / maxSlide;
        final double completion =
            rawCompletion.clamp(0.0, 1.0).toDouble();

        void handleDragUpdate(DragUpdateDetails details) {
          if (!widget.enabled || _confirmed) return;
          _snapBackController.stop();
          final double advance =
              isRtl ? -details.delta.dx : details.delta.dx;
          setState(() {
            _dragOffset = (_dragOffset + advance).clamp(0.0, maxSlide);
          });
        }

        void handleDragEnd(DragEndDetails details) {
          if (!widget.enabled || _confirmed) return;
          final double completion =
              maxSlide <= 0 ? 0 : _dragOffset / maxSlide;
          if (completion >= widget.threshold) {
            setState(() {
              _dragOffset = maxSlide;
              _confirmed = true;
            });
            HapticFeedback.mediumImpact();
            widget.onConfirmed();
          } else {
            _animateBackToStart();
          }
        }

        return GestureDetector(
          key: const ValueKey('slide-to-confirm-track'),
          onHorizontalDragUpdate: handleDragUpdate,
          onHorizontalDragEnd: handleDragEnd,
          child: Container(
            width: double.infinity,
            height: trackHeight,
            decoration: BoxDecoration(
              color: track,
              borderRadius:
                  BorderRadius.circular(context.radius.full.r),
              border: Border.all(color: progress, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(context.radius.full.r),
              child: Stack(
              children: [
                // التقدم المملوء خلف القرص على شكل كبسولة كاملة حتى
                // تبقى نهايته مخفية تماماً خلف القرص الدائري دون أي
                // زوايا مربعة.
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  bottom: 0,
                  width: edgePadding + _dragOffset + thumbSize,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progress.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(
                        context.radius.full.r,
                      ),
                    ),
                  ),
                ),
                // تلميح الوجهة عند نهاية المسار: دائرة شبح مع أسهم
                // الاتجاه، يتلاشى مع اقتراب القرص.
                PositionedDirectional(
                  end: edgePadding,
                  top: edgePadding,
                  bottom: edgePadding,
                  child: Opacity(
                    key: const ValueKey('slide-to-confirm-hint'),
                    opacity: 1 - completion,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: ghost,
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: hintIconWidget),
                    ),
                  ),
                ),
                PositionedDirectional(
                  end: edgePadding + thumbSize + 4.w,
                  top: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 1 - completion,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ملاحظة: اتجاه النص مثبّت على LTR حتى لا تنعكس
                          // الأسهم تلقائياً: الخاصية matchTextDirection=true
                          // في chevron_left كانت ستعرضها معكوسة داخل مسار RTL.
                          Icon(chevronIcon,
                              size: 18.sp,
                              color: progress,
                              textDirection: TextDirection.ltr),
                          Icon(chevronIcon,
                              size: 18.sp,
                              color: progress,
                              textDirection: TextDirection.ltr),
                          Icon(chevronIcon,
                              size: 18.sp,
                              color: progress,
                              textDirection: TextDirection.ltr),
                        ],
                      ),
                    ),
                  ),
                ),
                // النص المتمركز يبقى في المنتصف أثناء حركة القرص.
                IgnorePointer(
                  child: Center(
                    child: Text(
                      widget.label,
                      key: const ValueKey('slide-to-confirm-label'),
                      style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: widget.labelColor ?? progress,
                          ) ??
                          TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: widget.labelColor ?? progress,
                          ),
                    ),
                  ),
                ),
                // القرص الدائري القابل للسحب عند بداية المسار.
                PositionedDirectional(
                  start: edgePadding + _dragOffset,
                  top: edgePadding,
                  bottom: edgePadding,
                  child: Container(
                    key:
                        const ValueKey('slide-to-confirm-thumb'),
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: thumb,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: thumbIconWidget),
                  ),
                ),
              ],
              ),
            ),
          ),
        );
      },
      ),
    );
  }
}
