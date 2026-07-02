import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/divider_with_text.dart';
import 'package:elfulk/src/core/widgets/footer_text.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:elfulk/src/core/widgets/social_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isTermsAccepted = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ابدأ رحلتك مع الفلك.',
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
            'أنشئ حسابك في دقيقة وامنح طفلك فضاءً رقميًا آمنًا.',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: context.spacing.lg.h),

          CustomTextField(
            hintText: 'الاسم كامل',
            prefixIcon: SvgPicture.asset(AssetsPathHelper.profile),
          ),
          SizedBox(height: context.spacing.md.h),

          CustomTextField(
            hintText: 'البريد الإلكتروني',
            prefixIcon: SvgPicture.asset(AssetsPathHelper.email),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: context.spacing.md.h),

          CustomTextField(
            hintText: 'كلمة المرور',
            prefixIcon: SvgPicture.asset(AssetsPathHelper.lock),
            isPassword: true,
          ),
          SizedBox(height: context.spacing.md.h),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isTermsAccepted = !_isTermsAccepted;
                  });
                },
                child: Icon(
                  _isTermsAccepted ? Icons.check_circle : Icons.circle_outlined,
                  color: theme.colorScheme.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: context.spacing.sm.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'أوافق على ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ) ??
                        TextStyle(
                          fontSize: 12.sp,
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                    children: [
                      TextSpan(
                        text: 'شروط الاستخدام وسياسة الخصوصية.',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacing.lg.h),

          PrimaryButton(
            text: 'انشاء حساب',
            icon: SvgPicture.asset(AssetsPathHelper.login),
            onPressed: _isTermsAccepted
                ? () {
                    // Register logic
                  }
                : null,
          ),

          SizedBox(height: context.spacing.xl.h),

          FooterText(
            questionText: 'لديك حساب بالفعل؟ ',
            actionText: 'سجل الدخول',
            onActionTap: () => context.pop(),
          ),

          SizedBox(height: context.spacing.md.h),

          const DividerWithText(text: 'او عن طريق'),

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
