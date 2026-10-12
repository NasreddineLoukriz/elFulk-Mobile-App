/// نماذج لوحة الرئيسية (بيانات عرض خالصة — تُغذى dummy محلياً).
class ChildProfile {
  final String name;
  final String usagePrefix;
  final String usageValue;
  final String ageLabel;
  final String ageValue;
  final String genderLabel;
  final String genderValue;
  final String alertsLabel;
  final String alertsValue;

  const ChildProfile({
    required this.name,
    required this.usagePrefix,
    required this.usageValue,
    required this.ageLabel,
    required this.ageValue,
    required this.genderLabel,
    required this.genderValue,
    required this.alertsLabel,
    required this.alertsValue,
  });
}

/// فئة نشاط واحدة في بطاقة الإحصائيات.
class ActivitySlice {
  final String label;
  final double fraction;
  final String percentLabel;

  const ActivitySlice({
    required this.label,
    required this.fraction,
    required this.percentLabel,
  });
}

/// صف مكتبة واحد.
class LibraryRowData {
  final String title;
  final List<String> tags;
  final String? badge;

  const LibraryRowData({
    required this.title,
    this.tags = const <String>[],
    this.badge,
  });
}

/// قسم مكتبة (فيديوهات/قصص).
class LibrarySectionData {
  final String title;
  final String? childLabel;
  final List<LibraryRowData> rows;
  final String actionLabel;

  const LibrarySectionData({
    required this.title,
    this.childLabel,
    required this.rows,
    required this.actionLabel,
  });
}

/// معلومات جهاز مرتبط.
class DeviceInfo {
  final String deviceName;
  final String userName;
  final String statusLabel;
  final String statusValue;
  final String usageLabel;
  final String usageValue;
  final String enrolledLabel;
  final String enrolledValue;

  const DeviceInfo({
    required this.deviceName,
    required this.userName,
    required this.statusLabel,
    required this.statusValue,
    required this.usageLabel,
    required this.usageValue,
    required this.enrolledLabel,
    required this.enrolledValue,
  });
}

/// حمولة لوحة الرئيسية كاملة (تحية + أطفال + نشاط + مكتبة + أجهزة).
class HomeDashboard {
  final String greetingTitle;
  final String greetingSubtitle;
  final int notificationCount;
  final List<ChildProfile> children;
  final String activityTitle;
  final String activityChildLabel;
  final String allowedLine;
  final String remainingLine;
  final double progress;
  final String progressStartLabel;
  final String progressEndLabel;
  final List<ActivitySlice> categories;
  final String reportActionLabel;
  final List<LibrarySectionData> sections;
  final List<DeviceInfo> devices;

  const HomeDashboard({
    required this.greetingTitle,
    required this.greetingSubtitle,
    required this.notificationCount,
    required this.children,
    required this.activityTitle,
    required this.activityChildLabel,
    required this.allowedLine,
    required this.remainingLine,
    required this.progress,
    required this.progressStartLabel,
    required this.progressEndLabel,
    required this.categories,
    required this.reportActionLabel,
    required this.sections,
    required this.devices,
  });
}
