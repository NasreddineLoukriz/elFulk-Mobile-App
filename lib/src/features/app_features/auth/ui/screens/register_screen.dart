import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
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

/// شاشة إنشاء حساب جديد ثم الانتقال إلى تحقق البريد.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final TapGestureRecognizer _privacyRecognizer;

  bool _isTermsAccepted = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _termsError;
  String? _formError;

  @override
  void initState() {
    super.initState();
    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = () => context.push(Routes.privacyScreen);
  }

  @override
  void dispose() {
    _privacyRecognizer.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String? nameError = validateName(name);
    final String? emailError = validateEmail(email);
    final String? passwordError = validatePassword(password);
    final String? termsError = _isTermsAccepted
        ? null
        : 'يجب الموافقة على الشروط للمتابعة';

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
      _passwordError = passwordError;
      _termsError = termsError;
      _formError = null;
    });

    if (nameError != null ||
        emailError != null ||
        passwordError != null ||
        termsError != null) {
      return;
    }

    context.read<AuthCubit>().register(
      name: name,
      email: email,
      password: password,
    );
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
            context.push('${Routes.otpVerificationScreen}?type=email');
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
                'ابدأ رحلتك مع الفلك.',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: context.spacing.s.h),
              Text(
                'أنشئ حسابك في دقيقة وامنح طفلك فضاءً رقميًا آمنًا.',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: context.spacing.lg.h),

              CustomTextField(
                key: const ValueKey<String>('register-name'),
                controller: _nameController,
                hintText: 'الاسم الكامل',
                prefixIcon: SvgPicture.asset(AssetsPathHelper.profile),
                textInputAction: TextInputAction.next,
                errorText: _nameError,
                onChanged: (_) {
                  if (_nameError != null) {
                    setState(() => _nameError = null);
                  }
                },
              ),
              SizedBox(height: context.spacing.md.h),

              CustomTextField(
                key: const ValueKey<String>('register-email'),
                controller: _emailController,
                hintText: 'البريد الإلكتروني',
                prefixIcon: SvgPicture.asset(AssetsPathHelper.email),
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
                key: const ValueKey<String>('register-password'),
                controller: _passwordController,
                hintText: 'كلمة المرور',
                prefixIcon: SvgPicture.asset(AssetsPathHelper.lock),
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
              SizedBox(height: context.spacing.md.h),

              Row(
                children: <Widget>[
                  GestureDetector(
                    key: const ValueKey<String>('register-terms'),
                    onTap: () {
                      setState(() {
                        _isTermsAccepted = !_isTermsAccepted;
                        if (_isTermsAccepted) {
                          _termsError = null;
                        }
                      });
                    },
                    child: Icon(
                      _isTermsAccepted
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: theme.colorScheme.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: context.spacing.sm.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'أوافق على شروط الاستخدام و',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'سياسة الخصوصية.',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: _privacyRecognizer,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (_termsError != null) FormErrorText(message: _termsError!),
              SizedBox(height: context.spacing.lg.h),

              PrimaryButton(
                key: const ValueKey<String>('register-submit'),
                text: 'إنشاء حساب',
                icon: SvgPicture.asset(AssetsPathHelper.login),
                onPressed: isLoading ? null : _submit,
              ),
              if (_formError != null) FormErrorText(message: _formError!),

              SizedBox(height: context.spacing.xl.h),

              FooterText(
                questionText: 'لديك حساب بالفعل؟ ',
                actionText: 'سجّل الدخول',
                onActionTap: () => context.go(Routes.loginScreen),
              ),

              SizedBox(height: context.spacing.md.h),

              const DividerWithText(text: 'أو عن طريق'),

              SizedBox(height: context.spacing.md.h),

              Row(
                children: <Widget>[
                  Expanded(
                    child: SocialButton(
                      key: const ValueKey<String>('register-apple'),
                      iconSize: 22.sp,
                      icon: SvgPicture.asset(AssetsPathHelper.apple),
                      type: 'Apple',
                      onPressed: () => showSocialUnavailable(context),
                    ),
                  ),
                  SizedBox(width: context.spacing.md.w),
                  Expanded(
                    child: SocialButton(
                      key: const ValueKey<String>('register-google'),
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
