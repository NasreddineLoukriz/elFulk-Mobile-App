import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/widgets/parent_bottom_nav.dart';

/// هيكل التبويبات لتطبيق الأب: جسم الفرع النشط + شريط التنقل السفلي.
///
/// يُستخدم كـ `builder` في `StatefulShellRoute.indexedStack` فيمرّر
/// `navigationShell` مباشرة. الضغط على التبويب النشط نفسه يعيده
/// لجذره (`initialLocation: true`) حسب سلوك التبويبات القياسي.
/// (هيكل الطفل المنفصل يأتي في P4 مع `KidBottomNav`.)
class ParentShellScaffold extends StatelessWidget {
  /// غلاف التنقل الحالِي من الـ shell (يحمل الفروع والمؤشر).
  final StatefulNavigationShell navigationShell;

  const ParentShellScaffold({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ParentBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
