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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'مرحبًا بك في فلك.',
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
          SizedBox(height: context.spacing.s.h),
          Text(
            'سجّل دخولك للوصول إلى لوحة التحكم ومتابعة أطفالك',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: context.spacing.lg.h),

          CustomTextField(
            hintText: 'البريد الإلكتروني',
            prefixIcon: SvgPicture.asset(
              AssetsPathHelper.email,
              height: 20.w,
              width: 20.w,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: context.spacing.md.h),

          CustomTextField(
            hintText: 'كلمة المرور',
            prefixIcon: SvgPicture.asset(
              AssetsPathHelper.lock,
              height: 20.w,
              width: 20.w,
            ),
            isPassword: true,
          ),

          SizedBox(height: context.spacing.xs.h),

          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => context.push(Routes.forgetPasswordScreen),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'نسيت كلمة المرور؟',
                style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ) ??
                    TextStyle(
                      fontSize: 12.sp,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg.h),

          PrimaryButton(
            text: 'تسجيل الدخول',
            icon: SvgPicture.asset(AssetsPathHelper.login),
            onPressed: () {
              // Login logic
            },
          ),

          SizedBox(height: context.spacing.xl.h),

          FooterText(
            questionText: 'ليس لديك حساب؟ ',
            actionText: 'أنشئ واحدًا الآن',
            onActionTap: () => context.push(Routes.registerScreen),
          ),

          SizedBox(height: context.spacing.md.h),

          const DividerWithText(text: 'أو عن طريق'),

          SizedBox(height: context.spacing.md.h),

          Row(
            children: [
              Expanded(
                child: SocialButton(
                  iconSize: 22.sp,
                  icon: SvgPicture.asset(AssetsPathHelper.apple),
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
