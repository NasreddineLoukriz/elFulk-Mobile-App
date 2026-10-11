import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// شريط التنقل السفلي لتطبيق الأب (4 تبويبات حسب التصميم المرجعي).
///
/// الترتيب منطقياً: حسابي ← مركز التحكم ← النشاط ← الرئيسية، فيُعرض من
/// اليمين إلى اليسار تلقائياً في اتجاه RTL. اللون النشط من
/// `colorScheme.primary` والباقي خافت. يُستخدم داخل
/// [ParentShellScaffold] (لاحقاً: `KidBottomNav` منفصل للطفل بثلاثة
/// تبويبات في P4).
class ParentBottomNav extends StatelessWidget {
  /// مؤشر الفرع النشط حالياً (من `navigationShell.currentIndex`).
  final int currentIndex;

  /// يُستدعى بمؤشر التبويب المضغوط (يُمرَّر عادة لـ `goBranch`).
  final ValueChanged<int> onTap;

  const ParentBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  /// التبويبات الأربعة بالترتيب المنطقي (حسابي أولاً).
  static const List<({String label, IconData icon})> items =
      <({String label, IconData icon})>[
    (label: 'حسابي', icon: Icons.person_outline),
    (label: 'مركز التحكم', icon: Icons.dashboard_outlined),
    (label: 'النشاط', icon: Icons.bar_chart_outlined),
    (label: 'الرئيسية', icon: Icons.home_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BottomNavigationBar(
      key: const ValueKey('parent-bottom-nav'),
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.colorScheme.surface,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor:
          theme.colorScheme.onSurface.withValues(alpha: 0.6),
      selectedFontSize: 12.sp,
      unselectedFontSize: 12.sp,
      items: <BottomNavigationBarItem>[
        for (final item in items)
          BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.label,
          ),
      ],
    );
  }
}
