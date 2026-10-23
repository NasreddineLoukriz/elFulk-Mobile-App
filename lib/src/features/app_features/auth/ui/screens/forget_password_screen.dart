import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/divider_with_text.dart';
import 'package:elfulk/src/core/widgets/footer_text.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:elfulk/src/core/widgets/social_button.dart';
import 'package:elfulk/src/features/app_features/auth/ui/auth_ui_helpers.dart';

/// شاشة طلب رمز استرداد كلمة المرور.
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final String email = _emailController.text.trim();
    final String? emailError = validateEmail(email);
    setState(() => _emailError = emailError);
    if (emailError != null) {
      return;
    }

    context.push('${Routes.otpVerificationScreen}?type=reset');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'نسيت كلمة المرور؟',
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: context.spacing.sm12.h),
          Text(
            'أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق.',
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: context.spacing.xl.h),

          CustomTextField(
            key: const ValueKey<String>('forgot-email'),
            controller: _emailController,
            hintText: 'البريد الإلكتروني',
            prefixIcon: SvgPicture.asset(AssetsPathHelper.email),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            errorText: _emailError,
            onChanged: (_) {
              if (_emailError != null) {
                setState(() => _emailError = null);
              }
            },
          ),
          SizedBox(height: context.spacing.lg.h),

          PrimaryButton(
            key: const ValueKey<String>('forgot-submit'),
            text: 'إرسال رمز التحقق',
            rtlIcon: true,
            icon: SvgPicture.asset(AssetsPathHelper.send),
            onPressed: _submit,
          ),
          SizedBox(height: context.spacing.lg.h),

          FooterText(
            questionText: 'تذكرت كلمة المرور الخاصة بك؟ ',
            actionText: 'سجّل الدخول',
            onActionTap: () => context.go(Routes.loginScreen),
          ),
          SizedBox(height: context.spacing.xl.h),

          const DividerWithText(text: 'أو عن طريق'),
          SizedBox(height: context.spacing.lg.h),

          Row(
            children: <Widget>[
              Expanded(
                child: SocialButton(
                  key: const ValueKey<String>('forgot-apple'),
                  icon: SvgPicture.asset(AssetsPathHelper.apple),
                  iconSize: 22.sp,
                  type: 'Apple',
                  onPressed: () => showSocialUnavailable(context),
                ),
              ),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: SocialButton(
                  key: const ValueKey<String>('forgot-google'),
                  iconSize: 30.sp,
                  icon: SvgPicture.asset(AssetsPathHelper.google),
                  type: 'Google',
                  onPressed: () => showSocialUnavailable(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
