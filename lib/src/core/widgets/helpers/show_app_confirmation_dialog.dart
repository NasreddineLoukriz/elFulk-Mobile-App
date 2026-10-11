import 'package:flutter/material.dart';

import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';

/// يعرض [AppConfirmationDialog] مبنياً من [config] ويحوّل الإغلاق إلى
/// نتيجة مكتوبة النوع.
///
/// يُرجع `true` عند تأكيد المستخدم للإجراء الرئيسي (ضغط الزر العادي أو
/// إكمال السحب)، و`false` عند ضغط الزر الثانوي (أو عندما يُغلق
/// `onSecondaryAction` المخصص الحوار بقيمة `false`)، و`null` عند إغلاق
/// الحوار بالضغط خارجه أو بزر الرجوع في النظام (فقط عندما يكون
/// [barrierDismissible] بقيمة true).
///
/// الحوار نفسه لا يسجّل (log) أي شيء من [config] أو أي نص يستقبله.
Future<bool?> showAppConfirmationDialog({
  required BuildContext context,
  required AppConfirmationConfig config,
  bool barrierDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AppConfirmationDialog(config: config),
  );
}
