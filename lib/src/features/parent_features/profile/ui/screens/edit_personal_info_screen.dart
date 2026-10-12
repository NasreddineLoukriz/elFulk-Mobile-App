import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/check_row.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';

/// تعديل البيانات الشخصية حسب التصميم (عربي RTL).
///
/// 4 حقول (اسم/لقب/بريد/هاتف) + صف موافقة + حفظ مع تحقق محلي.
/// لا يُرسل شيء للشبكة (تخزين حقيقي في Phase 2 للخادم).
class EditPersonalInfoScreen extends StatefulWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  State<EditPersonalInfoScreen> createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  final TextEditingController _first = TextEditingController();
  final TextEditingController _last = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  bool _agreed = false;
  bool _showErrors = false;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل البيانات الشخصية'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            CustomTextField(
              hintText: 'الاسم الأول',
              prefixIcon: SvgPicture.asset('assets/icons/profile.svg'),
              controller: _first,
              hasError: _showErrors && _first.text.trim().isEmpty,
            ),
            SizedBox(height: context.spacing.md.h),
            CustomTextField(
              hintText: 'اسم العائلة',
              prefixIcon: SvgPicture.asset('assets/icons/profile.svg'),
              controller: _last,
              hasError: _showErrors && _last.text.trim().isEmpty,
            ),
            SizedBox(height: context.spacing.md.h),
            CustomTextField(
              hintText: 'البريد الإلكتروني',
              prefixIcon: SvgPicture.asset('assets/icons/email.svg'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              hasError: _showErrors && !_email.text.contains('@'),
            ),
            SizedBox(height: context.spacing.md.h),
            CustomTextField(
              hintText: 'رقم الهاتف',
              prefixIcon: SvgPicture.asset('assets/icons/profile.svg'),
              controller: _phone,
              keyboardType: TextInputType.phone,
              hasError: _showErrors && _phone.text.trim().isEmpty,
            ),
            CheckRow(
              label: 'أوافق على شروط الاستخدام وسياسة الخصوصية.',
              value: _agreed,
              onChanged: (bool v) => setState(() => _agreed = v),
            ),
            SizedBox(height: context.spacing.lg.h),
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
    final bool valid = _first.text.trim().isNotEmpty &&
        _last.text.trim().isNotEmpty &&
        _email.text.contains('@') &&
        _phone.text.trim().isNotEmpty &&
        _agreed;
    setState(() => _showErrors = !valid);
    if (!valid) return;
    // ملاحظة: الـ SnackBar يُعرض أولاً مع مهلة ليراه المستخدم، لأن
    // عرضه مع pop() فوري يُبتلع ولا يظهر أبداً (مثبت باختبار).
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ البيانات بنجاح.')),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (mounted) Navigator.of(context).pop();
  }
}
