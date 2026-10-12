import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/custom_pin_keypad.dart';
import 'package:elfulk/src/core/widgets/pin_display_row.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// يعرض ورقة سفلية بتصميم موحد: مقبض + عنوان + محتوى.
///
/// تُستخدم كأساس لستائر P1 (السياسة، إدخال PIN، الهاتف) فلا يتكرر
/// كروم الستارة. تُرجع ما تُرجعه دالة `builder` عبر `Navigator.pop`.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext sheetContext) builder,
}) {
  final ThemeData theme = Theme.of(context);

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: theme.colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.radius.x3l.r),
      ),
    ),
    builder: (BuildContext sheetContext) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.lg.w,
          vertical: context.spacing.md.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(context.radius.full.r),
              ),
            ),
            SizedBox(height: context.spacing.md.h),
            builder(sheetContext),
          ],
        ),
      ),
    ),
  );
}

/// عنوان ستارة بتنسيق موحد (متمركز، عريض).
class SheetTitle extends StatelessWidget {
  final String text;

  const SheetTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w800,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

/// يعرض ستارة مراجعة سياسة الخصوصية (نص قابل للتمرير + زر ثابت).
///
/// يُرجع `true` عند الموافقة، `null` عند الإغلاق.
Future<bool?> showPolicyReviewSheet({
  required BuildContext context,
  required String title,
  required String body,
  required String confirmLabel,
}) {
  return showAppBottomSheet<bool>(
    context: context,
    builder: (BuildContext sheetContext) {
      final ThemeData theme = Theme.of(sheetContext);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SheetTitle(text: title),
          SizedBox(height: context.spacing.md.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 320.h),
            child: SingleChildScrollView(
              child: Text(
                body,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.7,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg.h),
          SizedBox(
            height: 42.h,
            child: ElevatedButton(
              onPressed: () => Navigator.of(sheetContext).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radius.xxl.r),
                ),
                elevation: 0,
              ),
              child: Text(
                confirmLabel,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      );
    },
  );
}

/// يعرض ستارة إدخال PIN بلوحة الأرقام المخصصة.
///
/// تُرجع الرمز المدخل عند اكتماله والضغط على زر التأكيد، أو `null`
/// عند الإغلاق. حد `length` افتراضياً 5 خانات كما في التصميم.
Future<String?> showPinEntrySheet({
  required BuildContext context,
  required String title,
  required String confirmLabel,
  int length = 5,
  String? hint,
  String? forgotLabel,
  VoidCallback? onForgot,
}) {
  return showAppBottomSheet<String>(
    context: context,
    builder: (BuildContext sheetContext) => _PinEntryBody(
      title: title,
      confirmLabel: confirmLabel,
      length: length,
      hint: hint,
      forgotLabel: forgotLabel,
      onForgot: onForgot,
    ),
  );
}

/// جسم ستارة PIN (حالَة الأرقام المدخلة يملكها هنا).
class _PinEntryBody extends StatefulWidget {
  final String title;
  final String confirmLabel;
  final int length;
  final String? hint;
  final String? forgotLabel;
  final VoidCallback? onForgot;

  const _PinEntryBody({
    required this.title,
    required this.confirmLabel,
    required this.length,
    this.hint,
    this.forgotLabel,
    this.onForgot,
  });

  @override
  State<_PinEntryBody> createState() => _PinEntryBodyState();
}

class _PinEntryBodyState extends State<_PinEntryBody> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool complete = _value.length >= widget.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetTitle(text: widget.title),
        if (widget.hint != null) ...[
          SizedBox(height: context.spacing.sm.h),
          Text(
            widget.hint!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
        SizedBox(height: context.spacing.lg.h),
        PinDisplayRow(value: _value, length: widget.length),
        SizedBox(height: context.spacing.lg.h),
        CustomPinKeypad(
          onDigitPressed: (String digit) {
            if (_value.length >= widget.length) return;
            setState(() => _value += digit);
          },
          onBackspacePressed: () {
            if (_value.isEmpty) return;
            setState(() => _value = _value.substring(0, _value.length - 1));
          },
          onClearPressed: () => setState(() => _value = ''),
        ),
        if (widget.forgotLabel != null) ...[
          SizedBox(height: context.spacing.sm.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: widget.onForgot,
              child: Text(widget.forgotLabel!),
            ),
          ),
        ],
        SizedBox(height: context.spacing.md.h),
        SizedBox(
          height: 42.h,
          child: ElevatedButton(
            onPressed: complete
                ? () => Navigator.of(context).pop(_value)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.radius.xxl.r),
              ),
              elevation: 0,
            ),
            child: Text(
              widget.confirmLabel,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

/// يعرض ستارة إدخال رقم الهاتف (حقل + حفظ).
///
/// تُرجع الرقم المدخل عند الحفظ، أو `null` عند الإغلاق.
///
/// ملاحظة أمان دورة حياة: الـ controller تملكه الستارة نفسها
/// ([_AddPhoneSheetBody]) لا هذه الدالة — إعدامه خارجياً بعد pop
/// يُفكك EditableText أثناء أنيميشن الخروج ويُسقط assertion
/// `_dependents.isEmpty` في نسخ debug.
Future<String?> showAddPhoneSheet({
  required BuildContext context,
  required String title,
  required String hint,
  required String saveLabel,
  required Widget prefixIcon,
}) {
  return showAppBottomSheet<String>(
    context: context,
    builder: (BuildContext sheetContext) => _AddPhoneSheetBody(
      title: title,
      hint: hint,
      saveLabel: saveLabel,
      prefixIcon: prefixIcon,
    ),
  );
}

/// جسم ستارة الهاتف — يملك الـ controller الخاص به.
class _AddPhoneSheetBody extends StatefulWidget {
  final String title;
  final String hint;
  final String saveLabel;
  final Widget prefixIcon;

  const _AddPhoneSheetBody({
    required this.title,
    required this.hint,
    required this.saveLabel,
    required this.prefixIcon,
  });

  @override
  State<_AddPhoneSheetBody> createState() => _AddPhoneSheetBodyState();
}

class _AddPhoneSheetBodyState extends State<_AddPhoneSheetBody> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetTitle(text: widget.title),
        SizedBox(height: context.spacing.lg.h),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.radius.xl.r),
            ),
          ),
        ),
        SizedBox(height: context.spacing.lg.h),
        PrimaryButton(
          text: widget.saveLabel,
          icon: SvgPicture.asset(
            'assets/icons/verify.svg',
            width: 20.w,
            height: 20.h,
          ),
          onPressed: () =>
              Navigator.of(context).pop(_controller.text),
        ),
      ],
    );
  }
}
