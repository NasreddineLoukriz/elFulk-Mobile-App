import 'package:flutter/material.dart';

/// تحقق موحّد من صيغة البريد الإلكتروني.
String? validateEmail(String value) {
  final String email = value.trim();
  if (email.isEmpty) {
    return 'البريد الإلكتروني مطلوب';
  }
  final RegExp pattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
  if (!pattern.hasMatch(email)) {
    return 'أدخل بريدًا إلكترونيًا صحيحًا';
  }
  return null;
}

/// تحقق موحّد من طول كلمة المرور (6 أحرف على الأقل).
String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'كلمة المرور مطلوبة';
  }
  if (value.length < 6) {
    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
  }
  return null;
}

/// تحقق من الاسم الكامل.
String? validateName(String value) {
  if (value.trim().isEmpty) {
    return 'الاسم الكامل مطلوب';
  }
  return null;
}

/// تنبيه أن الدخول الاجتماعي غير مفعّل في النسخة التجريبية.
void showSocialUnavailable(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Text('تسجيل الدخول الاجتماعي غير متاح في النسخة التجريبية.'),
      ),
    );
}
