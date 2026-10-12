import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';

/// تغيير كلمة مرور الحساب حسب التصميم (عربي RTL).
///
/// 3 حقول (الحالية/الجديدة/التأكيد) + رابط النسيان + حفظ مع تحقق
/// محلي (التطابق والطول). لا تُرسل كلمة المرور لأي سجل — تُستخدم
/// للتحقق فقط ثم تُتجاهل.
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _current = TextEditingController();
  final TextEditingController _fresh = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _showErrors = false;

  @override
  void dispose() {
    _current.dispose();
    _fresh.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تغيير كلمة مرور الحساب'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            Text(
              'أدخل كلمة المرور الحالية ثم الجديدة مرتين للتأكيد.',
              style: TextStyle(
                fontSize: 13.sp,
                color:
                    Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: context.spacing.md.h),
            CustomTextField(
              hintText: 'كلمة المرور الحالية',
              prefixIcon: SvgPicture.asset('assets/icons/lock.svg'),
              isPassword: true,
              controller: _current,
              hasError: _showErrors && _current.text.isEmpty,
            ),
            SizedBox(height: context.spacing.md.h),
            CustomTextField(
              hintText: 'كلمة المرور الجديدة',
              prefixIcon: SvgPicture.asset('assets/icons/lock.svg'),
              isPassword: true,
              controller: _fresh,
              hasError: _showErrors && _fresh.text.length < 6,
            ),
            SizedBox(height: context.spacing.md.h),
            CustomTextField(
              hintText: 'تأكيد كلمة المرور الجديدة',
              prefixIcon: SvgPicture.asset('assets/icons/lock.svg'),
              isPassword: true,
              controller: _confirm,
              hasError: _showErrors &&
                  (_confirm.text.isEmpty || _confirm.text != _fresh.text),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () =>
                    context.push(Routes.forgetPasswordScreen),
                child: const Text('نسيت كلمة المرور؟'),
              ),
            ),
            SizedBox(height: context.spacing.md.h),
            PrimaryButton(
              text: 'حفظ التعديلات',
              icon: SvgPicture.asset(
                'assets/icons/verify.svg',
                width: 20.w,
                height: 20.h,
              ),
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final bool valid = _current.text.isNotEmpty &&
        _fresh.text.length >= 6 &&
        _confirm.text == _fresh.text;
    setState(() => _showErrors = !valid);
    if (!valid) return;
    // أمان: تُمسح الحقول فوراً ولا تُخزَّن أو تُسجَّل في أي مكان.
    _current.clear();
    _fresh.clear();
    _confirm.clear();
    // ملاحظة: مهلة ليرى المستخدم التأكيد قبل الرجوع (pop فوري
    // يبتلع الـ SnackBar فلا يظهر أبداً — مثبت باختبار).
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح.')),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (mounted) Navigator.of(context).pop();
  }
}
