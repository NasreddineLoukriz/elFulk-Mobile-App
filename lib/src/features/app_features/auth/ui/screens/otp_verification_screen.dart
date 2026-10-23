import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_pin_keypad.dart';
import 'package:elfulk/src/core/widgets/footer_text.dart';
import 'package:elfulk/src/core/widgets/form_error_text.dart';
import 'package:elfulk/src/core/widgets/pin_display_row.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:elfulk/src/features/app_features/auth/logic/cubit/auth_cubit.dart';

/// نوع رمز التحقق: تأكيد بريد التسجيل أو استرداد كلمة المرور.
enum OtpVerificationType {
  emailVerification,
  passwordReset,
}

/// شاشة إدخال رمز التحقق (5 أرقام) مع مؤقّت إعادة الإرسال.
class OtpVerificationScreen extends StatefulWidget {
  final OtpVerificationType type;

  const OtpVerificationScreen({super.key, required this.type});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _otpLength = 5;
  static const int _resendSeconds = 63;

  String _otpCode = '';
  String? _error;
  int _resendToken = 0;

  void _onDigitPress(String digit) {
    if (_otpCode.length < _otpLength) {
      setState(() {
        _otpCode += digit;
        _error = null;
      });
    }
  }

  void _onBackspacePress() {
    if (_otpCode.isNotEmpty) {
      setState(() {
        _otpCode = _otpCode.substring(0, _otpCode.length - 1);
        _error = null;
      });
    }
  }

  void _onClearPress() {
    setState(() {
      _otpCode = '';
      _error = null;
    });
  }

  void _onResend() {
    setState(() {
      _otpCode = '';
      _error = null;
      _resendToken++;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('تم إرسال رمز تحقق جديد.')));
  }

  void _submit() {
    if (_otpCode != AuthCubit.demoOtpCode) {
      setState(() {
        _error = 'الرمز غير صحيح. حاول مرة أخرى.';
        _otpCode = '';
      });
      return;
    }

    if (widget.type == OtpVerificationType.emailVerification) {
      context.go(Routes.homeScreen);
    } else {
      context.push(Routes.resetPasswordScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isEmailActive =
        widget.type == OtpVerificationType.emailVerification;

    final String titleText = isEmailActive
        ? 'تفقد بريدك الإلكتروني.'
        : 'أرسلنا لك رمز التحقق.';
    final String buttonText = isEmailActive
        ? 'تأكيد الرمز'
        : 'إعادة تعيين كلمة مرور جديدة';

    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            titleText,
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            'أدخل الرمز المكون من 5 أرقام الذي أرسلناه.',
            style: theme.textTheme.bodyMedium,
          ),
          if (kDebugMode)
            Padding(
              padding: EdgeInsets.only(top: context.spacing.xs.h),
              child: Text(
                'رمز النسخة التجريبية: ${AuthCubit.demoOtpCode}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          SizedBox(height: context.spacing.lg.h),

          PinDisplayRow(value: _otpCode, length: _otpLength),
          if (_error != null) FormErrorText(message: _error!),
          SizedBox(height: context.spacing.md.h),

          FooterText(
            key: const ValueKey<String>('otp-resend'),
            countdownSeconds: _resendSeconds,
            restartToken: _resendToken,
            questionText: 'إعادة إرسال الرمز بعد ',
            actionText: 'أرسله',
            onActionTap: _onResend,
          ),

          SizedBox(height: context.spacing.md.h),

          PrimaryButton(
            key: const ValueKey<String>('otp-submit'),
            text: buttonText,
            icon: SvgPicture.asset(
              isEmailActive
                  ? AssetsPathHelper.verify
                  : AssetsPathHelper.reset,
            ),
            onPressed: _otpCode.length == _otpLength ? _submit : null,
          ),

          SizedBox(height: context.spacing.xl.h),
          CustomPinKeypad(
            onDigitPressed: _onDigitPress,
            onBackspacePressed: _onBackspacePress,
            onClearPressed: _onClearPress,
          ),
        ],
      ),
    );
  }
}
