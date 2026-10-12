/// محتوى المساعدة الثابت (placeholder عربي — النسخ القانونية
/// النهائية من فريق المحتوى).
class HelpContent {
  const HelpContent._();

  static const String aboutTitle = 'من نحن';
  static const String aboutBody =
      'الفُلك فضاء رقمي موجّه للطفل المسلم تحت إشراف والديه، يضم محتوى '
      'نافعاً وآمناً ومتوافقاً مع قيمنا: برامج تعليمية، قصص وسيرة، وألعاب '
      'تعليمية آمنة، مع أدوات للآباء للمتابعة والموافقة.';

  static const String privacyTitle = 'سياسة الخصوصية';
  static const String privacyBody =
      '1. المعلومات التي نجمعها\n'
      'نجمع بيانات الحساب الأساسية (الاسم والبريد) وبيانات استخدام الأطفال '
      'اللازمة لعمل مزايا الإشراف الأبوي فقط.\n\n'
      '2. استخدام المعلومات\n'
      'تُستخدم البيانات لتشغيل التطبيق وتحسين تجربة الأسرة، ولا تُباع '
      'ولا تُشارك مع أطراف ثالثة لأغراض تسويقية.\n\n'
      '3. حقوقك\n'
      'يمكنك طلب تصدير بياناتك أو حذف حسابك نهائياً من إعدادات الحساب.';

  static const List<FaqItem> faq = <FaqItem>[
    FaqItem(
      question: 'كيف أضيف طفلاً جديداً؟',
      answer:
          'من الحساب الشخصي اختر (أطفالي) ثم بطاقة (إضافة طفل جديد) واتبع الخطوات.',
    ),
    FaqItem(
      question: 'كيف أغيّر رمز القفل الأبوي؟',
      answer:
          'من إعدادات الحساب اختر (تغيير رمز القفل)، أدخل الرمز الحالي ثم الجديد وأكّده.',
    ),
    FaqItem(
      question: 'ماذا يحدث عند حذف الحساب؟',
      answer:
          'يؤدي حذف الحساب إلى إزالة جميع بيانات الأطفال والإعدادات والأجهزة المرتبطة بشكل كامل ونهائي.',
    ),
  ];

  static const List<LanguageOption> languages = <LanguageOption>[
    LanguageOption(code: 'ar', label: 'العربية'),
    LanguageOption(code: 'en', label: 'English'),
  ];

  static const String appVersion = 'نسخة التطبيق 1.0.0';
}

/// سؤال شائع واحد.
class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

/// لغة واحدة في شاشة اللغة.
class LanguageOption {
  final String code;
  final String label;

  const LanguageOption({required this.code, required this.label});
}
