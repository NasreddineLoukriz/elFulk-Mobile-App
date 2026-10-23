import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';
import 'package:elfulk/src/features/app_features/auth/ui/auth_ui_helpers.dart';

/// شاشة تعيين كلمة مرور جديدة بعد نجاح رمز الاسترداد.
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final String password = _passwordController.text;
    final String confirm = _confirmController.text;
    final String? passwordError = validatePassword(password);
    final String? confirmError = confirm.isEmpty
        ? 'تأكيد كلمة المرور مطلوب'
        : (confirm != password ? 'كلمتا المرور غير متطابقتين' : null);

    setState(() {
      _passwordError = passwordError;
      _confirmError = confirmError;
    });

    if (passwordError != null || confirmError != null) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('تم تحديث كلمة المرور بنجاح.')),
      );
    context.go(Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppScreenTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'تعيين كلمة مرور جديدة',
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: context.spacing.s.h),
          Text(
            'اختر كلمة مرور جديدة لحسابك ثم سجّل الدخول بها.',
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: context.spacing.lg.h),

          CustomTextField(
            key: const ValueKey<String>('reset-password'),
            controller: _passwordController,
            hintText: 'كلمة المرور الجديدة',
            prefixIcon: SvgPicture.asset(AssetsPathHelper.lock),
            isPassword: true,
            textInputAction: TextInputAction.next,
            errorText: _passwordError,
            onChanged: (_) {
              if (_passwordError != null) {
                setState(() => _passwordError = null);
              }
            },
          ),
          SizedBox(height: context.spacing.md.h),

          CustomTextField(
            key: const ValueKey<String>('reset-confirm'),
            controller: _confirmController,
            hintText: 'تأكيد كلمة المرور',
            prefixIcon: SvgPicture.asset(AssetsPathHelper.lock),
            isPassword: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            errorText: _confirmError,
            onChanged: (_) {
              if (_confirmError != null) {
                setState(() => _confirmError = null);
              }
            },
          ),
          SizedBox(height: context.spacing.lg.h),

          PrimaryButton(
            key: const ValueKey<String>('reset-submit'),
            text: 'حفظ كلمة المرور',
            icon: SvgPicture.asset(AssetsPathHelper.verify),
            onPressed: _submit,
          ),
          SizedBox(height: context.spacing.md.h),
        ],
      ),
    );
  }
}
