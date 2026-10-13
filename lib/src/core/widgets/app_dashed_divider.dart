import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// فاصل منقط أفقي حسب التصميم المرجعي (بطاقة قائمة الحساب).
///
/// خط رفيع بلون `outlineVariant` بنمط شرطة/فراغ. يُستخدم عبر
/// `SettingsListTile(dashedDivider: true)` غالباً.
class AppDashedDivider extends StatelessWidget {
  /// لون الخط (افتراضياً `outlineVariant`).
  final Color? color;

  /// طول الشرطة (افتراضياً 6).
  final double dashWidth;

  /// طول الفراغ (افتراضياً 4).
  final double dashGap;

  const AppDashedDivider({
    super.key,
    this.color,
    this.dashWidth = 6,
    this.dashGap = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 1.h,
      child: CustomPaint(
        painter: _DashedLinePainter(
          color: color ?? Theme.of(context).colorScheme.outlineVariant,
          dashWidth: dashWidth.w,
          dashGap: dashGap.w,
        ),
      ),
    );
  }
}

/// رسّام الخط المنقط (أفقي فقط).
class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;

  const _DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double y = size.height / 2;
    double x = 0;
    while (x < size.width) {
      final double end = (x + dashWidth).clamp(0.0, size.width);
      canvas.drawLine(Offset(x, y), Offset(end, y), paint);
      x = end + dashGap;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap;
  }
}
