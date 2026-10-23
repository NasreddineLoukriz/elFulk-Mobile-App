import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/divider_with_text.dart';
import 'package:elfulk/src/core/widgets/footer_text.dart';
import 'package:elfulk/src/core/widgets/form_error_text.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:elfulk/src/core/widgets/social_button.dart';
import 'package:elfulk/src/features/app_features/auth/logic/cubit/auth_cubit.dart';
import 'package:elfulk/src/features/app_features/auth/ui/auth_ui_helpers.dart';

/// شاشة تسجيل الدخول (البيانات الوهمية في النسخة التجريبية).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _formError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String? emailError = validateEmail(email);
    final String? passwordError = validatePassword(password);

    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
      _formError = null;
    });

    if (emailError != null || passwordError != null) {
      return;
    }

    context.read<AuthCubit>().login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppScreenTemplate(
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (AuthState previous, AuthState current) =>
            current is AuthAuthenticated || current is AuthFailure,
        listener: (BuildContext context, AuthState state) {
          if (state is AuthAuthenticated) {
            context.go(Routes.homeScreen);
          } else if (state is AuthFailure) {
            setState(() => _formError = state.message);
          }
        },
        builder: (BuildContext context, AuthState state) {
          final bool isLoading = state is AuthLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'مرحبًا بك في فلك.',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: context.spacing.s.h),
              Text(
                'سجّل دخولك للوصول إلى لوحة التحكم ومتابعة أطفالك',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: context.spacing.lg.h),

              CustomTextField(
                key: const ValueKey<String>('login-email'),
                controller: _emailController,
                hintText: 'البريد الإلكتروني',
                prefixIcon: SvgPicture.asset(
                  AssetsPathHelper.email,
                  height: 20.w,
                  width: 20.w,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                errorText: _emailError,
                onChanged: (_) {
                  if (_emailError != null) {
                    setState(() => _emailError = null);
                  }
                },
              ),
              SizedBox(height: context.spacing.md.h),

              CustomTextField(
                key: const ValueKey<String>('login-password'),
                controller: _passwordController,
                hintText: 'كلمة المرور',
                prefixIcon: SvgPicture.asset(
                  AssetsPathHelper.lock,
                  height: 20.w,
                  width: 20.w,
                ),
                isPassword: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                errorText: _passwordError,
                onChanged: (_) {
                  if (_passwordError != null) {
                    setState(() => _passwordError = null);
                  }
                },
              ),

              SizedBox(height: context.spacing.xs.h),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  key: const ValueKey<String>('login-forgot'),
                  onPressed: () => context.push(Routes.forgetPasswordScreen),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'نسيت كلمة المرور؟',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.spacing.lg.h),

              PrimaryButton(
                key: const ValueKey<String>('login-submit'),
                text: 'تسجيل الدخول',
                icon: SvgPicture.asset(AssetsPathHelper.login),
                onPressed: isLoading ? null : _submit,
              ),
              if (_formError != null) FormErrorText(message: _formError!),

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
                children: <Widget>[
                  Expanded(
                    child: SocialButton(
                      key: const ValueKey<String>('login-apple'),
                      iconSize: 22.sp,
                      icon: SvgPicture.asset(AssetsPathHelper.apple),
                      type: 'Apple',
                      onPressed: () => showSocialUnavailable(context),
                    ),
                  ),
                  SizedBox(width: context.spacing.md.w),
                  Expanded(
                    child: SocialButton(
                      key: const ValueKey<String>('login-google'),
                      iconSize: 30.sp,
                      icon: SvgPicture.asset(AssetsPathHelper.google),
                      type: 'Google',
                      onPressed: () => showSocialUnavailable(context),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
