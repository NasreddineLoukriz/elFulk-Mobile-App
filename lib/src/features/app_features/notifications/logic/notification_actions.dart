import 'package:flutter/material.dart';

import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/app_sheets.dart';
import 'package:elfulk/src/core/widgets/helpers/show_app_confirmation_dialog.dart';
import 'package:elfulk/src/features/app_features/notifications/data/models/notification_item.dart';
import 'package:elfulk/src/features/app_features/notifications/logic/cubit/notifications_cubit.dart';

/// يترجم إجراء بطاقة الإشعار إلى سلوك حقيقي (مشترك بين Home والقائمة).
Future<void> handleNotificationAction(
  BuildContext context,
  NotificationsCubit cubit,
  NotificationItem item, {
  required bool primary,
}) async {
  final NotificationAction action = primary
      ? item.primaryAction
      : item.secondaryAction;

  switch (action) {
    case NotificationAction.none:
      return;
    case NotificationAction.dismiss:
      cubit.dismiss(item.id);
      return;
    case NotificationAction.lock:
      final bool? confirmed = await showAppConfirmationDialog(
        context: context,
        config: const AppConfirmationConfig(
          title: 'هل تريد قفل الجهاز فوراً؟',
          message: 'سيتم قفل هذا الجهاز فوراً ولن يتمكن الطفل من استخدامه حتى إلغاء القفل.',
          icon: Icon(Icons.lock_outline_rounded),
          primaryActionType: AppConfirmationPrimaryActionType.destructive,
          primaryActionLabel: 'قفل الجهاز فوراً',
          secondaryActionLabel: 'إلغاء',
        ),
      );
      if (confirmed == true && context.mounted) {
        cubit.dismiss(item.id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تم قفل الجهاز فوراً.')));
      }
      return;
    case NotificationAction.policy:
      final bool? accepted = await showPolicyReviewSheet(
        context: context,
        title: item.title,
        body: item.body,
        confirmLabel: 'موافقة والمتابعة',
      );
      if (accepted == true && context.mounted) {
        cubit.dismiss(item.id);
      }
      return;
    case NotificationAction.pin:
      final String? pin = await showPinEntrySheet(
        context: context,
        title: 'قم بادخال رمز القفل الحالي',
        confirmLabel: 'التالي',
        forgotLabel: 'هل نسيت رمز المرور؟ إعادة تعيين',
      );
      if (pin != null && context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('تم التحقق من الرمز.')));
      }
      return;
    case NotificationAction.readMore:
      await showPolicyReviewSheet(
        context: context,
        title: item.title,
        body: item.body,
        confirmLabel: 'فهمت',
      );
      return;
  }
}
