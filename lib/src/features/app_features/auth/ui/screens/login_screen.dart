import 'package:elfulk/src/core/helpers/src/assets_path_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
// تأكد من صحة مسار الاستيراد بناءً على مجلد مشروعك
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:elfulk/src/core/widgets/divider_with_text.dart';
import 'package:elfulk/src/core/widgets/footer_text.dart';
import 'package:elfulk/src/core/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // النصوص العلوية
          Text(
            'مرحبًا بك في فلك.',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF10363A),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'سجّل دخولك للوصول إلى لوحة التحكم ومتابعة أطفالك',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 24.h),

          // حقل البريد الإلكتروني
          CustomTextField(
            hintText: 'البريد الإلكتروني',
            prefixIcon: SvgPicture.asset(
              AssetsPathHelper.email,
              height: 20.w,
              width: 20.w,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 14.h),

          // حقل كلمة المرور
          CustomTextField(
            hintText: 'كلمة المرور',
            prefixIcon: SvgPicture.asset(
              AssetsPathHelper.lock,
              height: 20.w,
              width: 20.w,
            ),
            isPassword: true,
          ),

          SizedBox(height: 4.h),

          // زر نسيت كلمة المرور؟
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
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF4DB09E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // زر تسجيل الدخول
          PrimaryButton(
            text: 'تسجيل الدخول',
            icon: SvgPicture.asset(AssetsPathHelper.login),
            onPressed: () {
              // Login logic
            },
          ),

          SizedBox(height: 32.h),

          // النص السفلي لإنشاء حساب
          FooterText(
            questionText: 'ليس لديك حساب؟ ',
            actionText: 'أنشئ واحدًا الآن',
            onActionTap: () => context.push(Routes.registerScreen),
          ),

          SizedBox(height: 16.h),

          // الفاصل المعنون
          const DividerWithText(text: 'أو عن طريق'),

          SizedBox(height: 16.h),

          // أزرار التسجيل عبر آبل وجوجل
          Row(
            children: [
              Expanded(
                child: SocialButton(
                  iconSize: 22.sp,
                  icon: SvgPicture.asset(AssetsPathHelper.apple),
                  type: 'Apple',
                  // appleIconSize: 22.sp,
                  onPressed: () {}, // إضافة منطق تسجيل دخول آبل
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: SocialButton(
                  iconSize: 30.sp,
                  icon: SvgPicture.asset(AssetsPathHelper.google),
                  type: 'Google',
                  // googleTextSize: 20.sp,
                  onPressed: () {}, // إضافة منطق تسجيل دخول جوجل
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
