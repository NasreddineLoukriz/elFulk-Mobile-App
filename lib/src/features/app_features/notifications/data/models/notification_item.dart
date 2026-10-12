import 'package:elfulk/src/core/widgets/notification_card.dart';

/// الإجراء المرتبط بزر البطاقة (يُترجم في الشاشة لسلوك حقيقي).
enum NotificationAction {
  /// لا إجراء (زر معطّل).
  none,

  /// حوار تأكيد القفل (destructive).
  lock,

  /// ورقة مراجعة (سياسة/تفاصيل).
  policy,

  /// ستارة إدخال PIN.
  pin,

  /// ورقة قراءة النص الكامل.
  readMore,

  /// إزالة البطاقة من القائمة.
  dismiss,
}

/// عنصر إشعار واحد (بيانات عرض فقط — تُغذى dummy محلياً حتى
/// تتوفر endpoints الخادم في Phase 2).
class NotificationItem {
  final String id;
  final String? childLabel;
  final NotificationCategory category;
  final String categoryLabel;
  final String title;
  final String body;
  final String primaryLabel;
  final NotificationAction primaryAction;
  final String? secondaryLabel;
  final NotificationAction secondaryAction;
  final String group;

  const NotificationItem({
    required this.id,
    this.childLabel,
    required this.category,
    required this.categoryLabel,
    required this.title,
    required this.body,
    required this.primaryLabel,
    this.primaryAction = NotificationAction.none,
    this.secondaryLabel,
    this.secondaryAction = NotificationAction.none,
    required this.group,
  });
}

/// فلتر قائمة الإشعارات (رقاقات الصف العلوي).
enum NotificationFilter {
  all,
  alerts,
  time,
  content;

  /// التسمية المعروضة في الرقاقة.
  String get label => switch (this) {
    NotificationFilter.all => 'كل الإشعارات',
    NotificationFilter.alerts => 'التنبيهات',
    NotificationFilter.time => 'الوقت',
    NotificationFilter.content => 'المحتوى',
  };

  /// هل يظهر العنصر تحت هذا الفلتر.
  bool matches(NotificationItem item) => switch (this) {
    NotificationFilter.all => true,
    NotificationFilter.alerts => item.category == NotificationCategory.alerts,
    NotificationFilter.time => item.category == NotificationCategory.time,
    NotificationFilter.content => item.category == NotificationCategory.content,
  };
}
