/// طفل واحد في قائمة أطفالي (بيانات عرض ثابتة حتى تتوفر
/// endpoints الأبناء في Phase 2 للخادم).
class KidItem {
  final String name;
  final String age;
  final String gender;
  final String pendingLabel;

  const KidItem({
    required this.name,
    required this.age,
    required this.gender,
    required this.pendingLabel,
  });
}

/// مستودع الأطفال — بيانات dummy عربية محلية.
class KidsRepository {
  const KidsRepository();

  List<KidItem> fetchKids() => const <KidItem>[
        KidItem(
          name: 'أنس مالك',
          age: '08 سنوات',
          gender: 'ذكر',
          pendingLabel: '01 تنبيه',
        ),
        KidItem(
          name: 'ليلى مالك',
          age: '06 سنوات',
          gender: 'أنثى',
          pendingLabel: '02 تنبيه',
        ),
        KidItem(
          name: 'محمد مالك',
          age: '10 سنوات',
          gender: 'ذكر',
          pendingLabel: 'لا يوجد',
        ),
      ];
}
