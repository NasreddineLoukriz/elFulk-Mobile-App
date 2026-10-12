import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/check_row.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';

/// تواصل معنا حسب التصميم (عربي RTL).
///
/// نموذج (اسم/بريد/رسالة متعددة) + موافقة + زر إرسال يتحول لحالة
/// نجاح `تم الإرسال بنجاح ✓` بعد التحقق. لا إرسال شبكي بعد (Phase 2).
class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _message = TextEditingController();
  bool _agreed = false;
  bool _showErrors = false;
  bool _sent = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تواصل معنا'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            CustomTextField(
              hintText: 'الاسم الكامل',
              prefixIcon: SvgPicture.asset('assets/icons/profile.svg'),
              controller: _name,
              hasError: _showErrors && _name.text.trim().isEmpty,
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
              hintText: 'نص الرسالة',
              prefixIcon: SvgPicture.asset('assets/icons/edit.svg'),
              controller: _message,
              keyboardType: TextInputType.multiline,
              hasError: _showErrors && _message.text.trim().isEmpty,
            ),
            CheckRow(
              label: 'أوافق على سياسة التواصل ومعالجة رسالتي.',
              value: _agreed,
              onChanged: (bool v) => setState(() => _agreed = v),
            ),
            SizedBox(height: context.spacing.lg.h),
            PrimaryButton(
              text: _sent ? 'تم الإرسال بنجاح ✓' : 'إرسال',
              icon: SvgPicture.asset(
                'assets/icons/send.svg',
                width: 20.w,
                height: 20.h,
              ),
              onPressed: _sent ? null : _send,
            ),
          ],
        ),
      ),
    );
  }

  void _send() {
    final bool valid = _name.text.trim().isNotEmpty &&
        _email.text.contains('@') &&
        _message.text.trim().isNotEmpty &&
        _agreed;
    setState(() {
      _showErrors = !valid;
      _sent = valid;
    });
  }
}
