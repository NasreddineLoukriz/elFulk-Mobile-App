import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/core/widgets/notification_card.dart';
import 'package:elfulk/src/features/app_features/notifications/data/models/notification_item.dart';

/// مستودع الإشعارات — بيانات dummy عربية محلية خلف نفس العقد.
///
/// تُستبدل باستدعاءات `GET /notifications` الحقيقية في Phase 2 للخادم
/// دون تغيير الـ cubit أو الشاشة.
class NotificationsRepository {
  const NotificationsRepository();

  Future<ApiResult<List<NotificationItem>>> fetchNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const ApiResult.success(_seed);
  }

  static const List<NotificationItem> _seed = <NotificationItem>[
    NotificationItem(
      id: 'n1',
      childLabel: 'أنس مالك',
      category: NotificationCategory.alerts,
      categoryLabel: 'التنبيهات',
      title: 'تجاوز الحد الصحي الموصى به',
      body: 'تجاوز إجمالي وقت شاشة طفلك اليوم الحد الصحي الموصى به لفئته العمرية.',
      primaryLabel: 'قفل الجهاز فوراً',
      primaryAction: NotificationAction.lock,
      secondaryLabel: 'مراجعة التفاصيل',
      secondaryAction: NotificationAction.readMore,
      group: 'اليوم',
    ),
    NotificationItem(
      id: 'n2',
      childLabel: 'ليلى مالك',
      category: NotificationCategory.time,
      categoryLabel: 'الوقت',
      title: 'الاستخدام بعد وقت النوم',
      body: 'حاول طفلك استخدام التطبيق بعد وقت النوم المحدد.',
      primaryLabel: 'قفل الجهاز فوراً',
      primaryAction: NotificationAction.lock,
      secondaryLabel: 'مراجعة التفاصيل',
      secondaryAction: NotificationAction.readMore,
      group: 'اليوم',
    ),
    NotificationItem(
      id: 'n3',
      childLabel: 'محمد مالك',
      category: NotificationCategory.content,
      categoryLabel: 'المحتوى',
      title: 'محتوى جديد مقترح لطفلك',
      body: 'تمت إضافة فيديوهات جديدة مناسبة لعمر طفلك، يمكنك مراجعتها قبل العرض.',
      primaryLabel: 'مراجعة المحتوى',
      primaryAction: NotificationAction.readMore,
      secondaryLabel: 'تجاهل',
      secondaryAction: NotificationAction.dismiss,
      group: 'اليوم',
    ),
    NotificationItem(
      id: 'n4',
      category: NotificationCategory.system,
      categoryLabel: 'إشعارات النظام',
      title: 'تحديث سياسة الخصوصية',
      body: 'قمنا بتحديث سياسة الخصوصية. يرجى الموافقة والمتابعة لمواصلة الاستخدام.',
      primaryLabel: 'موافقة والمتابعة',
      primaryAction: NotificationAction.dismiss,
      secondaryLabel: 'قراءة الشروط',
      secondaryAction: NotificationAction.policy,
      group: 'البارحة',
    ),
    NotificationItem(
      id: 'n5',
      childLabel: 'ليلى مالك',
      category: NotificationCategory.security,
      categoryLabel: 'الأمان',
      title: 'محاولة الوصول إلى لوحة التحكم',
      body: 'رُصدت محاولة وصول غير مصرح بها إلى لوحة التحكم من جهاز طفلك.',
      primaryLabel: 'تغيير رمز القفل الأبوي',
      primaryAction: NotificationAction.pin,
      secondaryLabel: 'تجاهل',
      secondaryAction: NotificationAction.dismiss,
      group: 'البارحة',
    ),
    NotificationItem(
      id: 'n6',
      category: NotificationCategory.content,
      categoryLabel: 'التقارير',
      title: 'ملخص نشاط اليوم جاهز',
      body: 'أصبح ملخص نشاط أطفالك لليوم جاهزاً للمراجعة الكاملة.',
      primaryLabel: 'عرض التقرير',
      primaryAction: NotificationAction.readMore,
      secondaryLabel: 'لاحقاً',
      secondaryAction: NotificationAction.dismiss,
      group: 'الأسبوع الماضي',
    ),
  ];
}
