import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/divider_with_text.dart';
import 'package:elfulk/src/core/widgets/footer_text.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:elfulk/src/core/widgets/social_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'نسيت كلمة المرور؟',
            style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ) ??
                TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
          ),
          SizedBox(height: context.spacing.sm12.h),
          Text(
            'أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق.',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.spacing.xl.h),

          CustomTextField(
            hintText: 'البريد الإلكتروني',
            prefixIcon: SvgPicture.asset(AssetsPathHelper.email),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: context.spacing.lg.h),

          PrimaryButton(
            text: 'ارسال رمز التحقق',
            rtlIcon: true,
            icon: SvgPicture.asset(AssetsPathHelper.send),
            onPressed: () {
              // Send code logic
            },
          ),
          SizedBox(height: context.spacing.lg.h),

          FooterText(
            questionText: 'تذكرت كلمة المرور الخاصة بك؟ ',
            actionText: 'سجل الدخول',
            onActionTap: () => context.pop(),
          ),
          SizedBox(height: context.spacing.xl.h),

          const DividerWithText(text: 'او عن طريق'),
          SizedBox(height: context.spacing.lg.h),

          Row(
            children: [
              Expanded(
                child: SocialButton(
                  icon: SvgPicture.asset(AssetsPathHelper.apple),
                  iconSize: 22.sp,
                  type: 'Apple',
                  onPressed: () {},
                ),
              ),
              SizedBox(width: context.spacing.md.w),
              Expanded(
                child: SocialButton(
                  iconSize: 30.sp,
                  icon: SvgPicture.asset(AssetsPathHelper.google),
                  type: 'Google',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
