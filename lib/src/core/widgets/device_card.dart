import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// بطاقة جهاز مرتبط حسب التصميم المرجعي (عربي RTL).
///
/// التخطيط: صف علوي (أيقونة هاتف + اسم الجهاز)، ثم صفوف المعلومات
/// (المستخدم/الحالة/المدة/التسجيل)، ثم 3 أزرار صغيرة: قفل (أحمر
/// ملوّن) وإيقاف وتعديل (محايدين). كل النصوص بارامترات.
class DeviceCard extends StatelessWidget {
  /// اسم الجهاز (مثال: `'اسم الجهاز'`).
  final String deviceName;

  /// اسم مستخدم الجهاز (مثال: `'المستخدم أحمد محسن.'`).
  final String userName;

  /// تسمية الحالة (مثال: `'الحالة'`).
  final String statusLabel;

  /// قيمة الحالة (مثال: `'نشط حاليا'`).
  final String statusValue;

  /// لون قيمة الحالة (افتراضياً الرئيسي).
  final Color? statusColor;

  /// تسمية المدة (مثال: `'مدة الاستخدام'`).
  final String usageLabel;

  /// قيمة المدة (مثال: `'03 س و 10 د'`).
  final String usageValue;

  /// تسمية التسجيل (مثال: `'تاريخ التسجيل'`).
  final String enrolledLabel;

  /// قيمة التسجيل (مثال: `'30 أكتوبر 2026'`).
  final String enrolledValue;

  /// يُستدعى عند ضغط القفل (null = بلا زر).
  final VoidCallback? onLock;

  /// يُستدعى عند ضغط الإيقاف المؤقت (null = بلا زر).
  final VoidCallback? onPause;

  /// يُستدعى عند ضغط التعديل (null = بلا زر).
  final VoidCallback? onEdit;

  /// لون خلفية البطاقة (افتراضياً لون البطاقة من الثيم).
  final Color? backgroundColor;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.userName,
    required this.statusLabel,
    required this.statusValue,
    this.statusColor,
    required this.usageLabel,
    required this.usageValue,
    required this.enrolledLabel,
    required this.enrolledValue,
    this.onLock,
    this.onPause,
    this.onEdit,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color muted = theme.colorScheme.onSurface.withValues(alpha: 0.6);

    Widget info(String label, String value, {Color? valueColor}) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: muted),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: valueColor ?? theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    Widget smallButton({
      required IconData icon,
      required VoidCallback? onPressed,
      required Color border,
      required Color foreground,
      required String keyValue,
    }) {
      if (onPressed == null) return const SizedBox.shrink();
      return Expanded(
        child: SizedBox(
          height: 38.h,
          child: OutlinedButton(
            key: ValueKey<String>(keyValue),
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: foreground,
              side: BorderSide(color: border, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.radius.lg.r),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Icon(icon, size: 20.sp),
          ),
        ),
      );
    }

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
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(context.radius.lg.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.smartphone_outlined,
                      size: 22.sp,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(width: context.spacing.sm.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        deviceName,
                        key: const ValueKey('device-card-name'),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        userName,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 13.sp, color: muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.spacing.sm.h),
            Row(
              children: [
                info(
                  statusLabel,
                  statusValue,
                  valueColor: statusColor ?? theme.colorScheme.primary,
                ),
                info(usageLabel, usageValue),
                info(enrolledLabel, enrolledValue),
              ],
            ),
            SizedBox(height: context.spacing.sm.h),
            Row(
              children: [
                smallButton(
                  icon: Icons.lock_outline_rounded,
                  onPressed: onLock,
                  border: theme.colorScheme.error,
                  foreground: theme.colorScheme.error,
                  keyValue: 'device-card-lock',
                ),
                SizedBox(width: context.spacing.sm.w),
                smallButton(
                  icon: Icons.pause_rounded,
                  onPressed: onPause,
                  border: theme.colorScheme.outlineVariant,
                  foreground: theme.colorScheme.onSurface,
                  keyValue: 'device-card-pause',
                ),
                SizedBox(width: context.spacing.sm.w),
                smallButton(
                  icon: Icons.edit_outlined,
                  onPressed: onEdit,
                  border: theme.colorScheme.outlineVariant,
                  foreground: theme.colorScheme.onSurface,
                  keyValue: 'device-card-edit',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
