import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:elfulk/src/core/helpers/src/assets_path_helper.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/footer_text.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';

enum OtpVerificationType {
  emailVerification,
  passwordReset,
}

class OtpVerificationScreen extends StatefulWidget {
  final OtpVerificationType type;

  const OtpVerificationScreen({super.key, required this.type});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String _otpCode = '';

  void _onDigitPress(String digit) {
    if (_otpCode.length < 5) {
      setState(() {
        _otpCode += digit;
      });
    }
  }

  void _onBackspacePress() {
    if (_otpCode.isNotEmpty) {
      setState(() {
        _otpCode = _otpCode.substring(0, _otpCode.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isEmailActive =
        widget.type == OtpVerificationType.emailVerification;

    final String titleText = isEmailActive
        ? 'تفقد بريدك الالكتروني.'
        : 'أرسلنا لك رمز التحقق.';
    final String buttonText = isEmailActive
        ? 'تأكيد الرمز'
        : 'اعادة تعين كلمة مرور جديدة';

    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ) ??
                TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
          ),
          SizedBox(height: 8.h),
          Text(
            'ادخل الرمز المكون من 5 أرقام الذي أرسلناه.',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 24.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textDirection: TextDirection.ltr,
            children: List.generate(5, (index) {
              final bool isFilled = index < _otpCode.length;

              return Container(
                width: 50.w,
                height: 55.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isFilled
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  isFilled ? _otpCode[index] : '',
                  style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ) ??
                      TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                ),
              );
            }),
          ),
          SizedBox(height: 16.h),

          FooterText(
            countdownSeconds: 63,
            questionText: 'اعادة ارسال الرمز بعد ',
            actionText: "ارسلي",
            onActionTap: () {
              // Resend code logic
            },
          ),

          SizedBox(height: 16.h),

          PrimaryButton(
            text: buttonText,
            icon: SvgPicture.asset(
              isEmailActive
                  ? AssetsPathHelper.verify
                  : AssetsPathHelper.reset,
            ),
            onPressed: _otpCode.length == 5
                ? () {
                    // Verify logic
                  }
                : null,
          ),

          SizedBox(height: 32.h),
          _buildCustomKeypad(theme),
        ],
      ),
    );
  }

  Widget _buildCustomKeypad(ThemeData theme) {
    return Column(
      children: [
        _buildKeypadRow(theme, ['1', '2', '3']),
        SizedBox(height: 12.h),
        _buildKeypadRow(theme, ['4', '5', '6']),
        SizedBox(height: 12.h),
        _buildKeypadRow(theme, ['7', '8', '9']),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildKeypadButton(
              theme,
              icon: Icons.backspace_outlined,
              isBackspace: true,
            ),
            _buildKeypadButton(theme, text: '0'),
            _buildKeypadButton(theme, icon: Icons.refresh),
          ],
        ),
      ],
    );
  }

  Widget _buildKeypadRow(ThemeData theme, List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: digits.map((digit) => _buildKeypadButton(theme, text: digit)).toList(),
    );
  }

  Widget _buildKeypadButton(
    ThemeData theme, {
    String? text,
    IconData? icon,
    bool isBackspace = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (text != null) {
          _onDigitPress(text);
        } else if (isBackspace) {
          _onBackspacePress();
        } else {
          setState(() {
            _otpCode = '';
          });
        }
      },
      child: Container(
        width: 100.w,
        height: 42.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: text != null
              ? Text(
                  text,
                  style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ) ??
                      TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                )
              : Icon(icon, size: 24.sp, color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
