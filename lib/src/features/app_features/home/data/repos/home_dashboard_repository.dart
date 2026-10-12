import 'package:elfulk/src/core/networking/helper/api_result.dart';
import 'package:elfulk/src/features/app_features/home/data/models/dashboard_models.dart';

/// مستودع لوحة الرئيسية — بيانات dummy عربية محلية.
///
/// تُستبدل باستدعاءات حقيقية (تجميع `/parent/*` + endpoints جديدة)
/// في Phase 2 للخادم دون تغيير الـ cubit أو الشاشات.
class HomeDashboardRepository {
  const HomeDashboardRepository();

  Future<ApiResult<HomeDashboard>> fetchDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const ApiResult.success(_dashboard);
  }

  static const HomeDashboard _dashboard = HomeDashboard(
    greetingTitle: 'طاب يومك اسم المستخدم 👋',
    greetingSubtitle: 'تقارير أطفالك جاهزة للمراجعة!',
    notificationCount: 9,
    children: <ChildProfile>[
      ChildProfile(
        name: 'أنس مالك',
        usagePrefix: 'مدة الاستخدام اليوم:',
        usageValue: '2 ساعات و 10 دقائق.',
        ageLabel: 'العمر',
        ageValue: '08 سنوات',
        genderLabel: 'الجنس',
        genderValue: 'ذكر',
        alertsLabel: 'التنبيهات المعلقة',
        alertsValue: '01 تنبيه',
      ),
      ChildProfile(
        name: 'ليلى مالك',
        usagePrefix: 'مدة الاستخدام اليوم:',
        usageValue: '1 ساعة و 25 دقيقة.',
        ageLabel: 'العمر',
        ageValue: '06 سنوات',
        genderLabel: 'الجنس',
        genderValue: 'أنثى',
        alertsLabel: 'التنبيهات المعلقة',
        alertsValue: '02 تنبيه',
      ),
      ChildProfile(
        name: 'محمد مالك',
        usagePrefix: 'مدة الاستخدام اليوم:',
        usageValue: '45 دقيقة.',
        ageLabel: 'العمر',
        ageValue: '10 سنوات',
        genderLabel: 'الجنس',
        genderValue: 'ذكر',
        alertsLabel: 'التنبيهات المعلقة',
        alertsValue: 'لا يوجد',
      ),
    ],
    activityTitle: 'بعض بيانات النشاط داخل المنصة بأطفالك',
    activityChildLabel: 'أنس مالك',
    allowedLine: 'المدة المسموح بها: 2 ساعات و 30 دقيقة.',
    remainingLine: 'الوقت المتبقي من المدة المسموح بها هو: 27 دقيقة.',
    progress: 0.85,
    progressStartLabel: '0% من الوقت',
    progressEndLabel: '100% من الوقت',
    categories: <ActivitySlice>[
      ActivitySlice(
        label: 'الفيديوهات',
        fraction: 0.6,
        percentLabel: '60% من الوقت',
      ),
      ActivitySlice(
        label: 'القصص',
        fraction: 0.3,
        percentLabel: '30% من الوقت',
      ),
      ActivitySlice(
        label: 'الألعاب',
        fraction: 0.1,
        percentLabel: '10% من الوقت',
      ),
    ],
    reportActionLabel: 'عرض تقرير النشاط كامل',
    sections: <LibrarySectionData>[
      LibrarySectionData(
        title: 'اضيفة فيديوهات جديدة مقترحة من فريقنا لمكتبة',
        childLabel: 'أنس مالك',
        rows: <LibraryRowData>[
          LibraryRowData(
            title: 'الأرنب السريع وأصدقاء الغابة: كيف يفوز الأرنب دائماً في كل التحديات!',
            tags: <String>['تربية وقيم', 'علوم وتعليم'],
            badge: '15:12',
          ),
          LibraryRowData(
            title: 'رحلة الفضاء الصغير: اكتشاف الكواكب والمجرات البعيدة.',
            tags: <String>['علوم وتعليم'],
            badge: '08:45',
          ),
        ],
        actionLabel: 'عرض كامل مكتبة فيديوهات طفلك',
      ),
      LibrarySectionData(
        title: 'اضيفة قصص جديدة مقترحة من فريقنا لمكتبة',
        childLabel: 'أنس مالك',
        rows: <LibraryRowData>[
          LibraryRowData(
            title: 'قصة معركة بدر كاملة مع مواقف مفيدة.',
            tags: <String>['الأنبياء والسيرة', 'التاريخ والتراث'],
            badge: '4 من 12 فصل',
          ),
        ],
        actionLabel: 'عرض كامل مكتبة قصص طفلك',
      ),
    ],
    devices: <DeviceInfo>[
      DeviceInfo(
        deviceName: 'اسم الجهاز',
        userName: 'المستخدم أحمد محسن.',
        statusLabel: 'الحالة',
        statusValue: 'نشط حاليا',
        usageLabel: 'مدة الاستخدام',
        usageValue: '03 س و 10 د',
        enrolledLabel: 'تاريخ التسجيل',
        enrolledValue: '30 أكتوبر 2026',
      ),
    ],
  );
}
