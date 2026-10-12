import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';

/// رقاقة تبويب في ترويسة الرئيسية (أيقونة + نص).
class HomeTabChip {
  /// النص المعروض.
  final String label;

  /// الأيقونة.
  final IconData icon;

  const HomeTabChip({required this.label, required this.icon});
}

/// ترويسة الرئيسية حسب التصميم المرجعي (عربي RTL).
///
/// صف علوي (جرس التنبيهات بشارة عدد + التحية والنص الفرعي)، يليه صف
/// رقاقات التبويبات الأفقي القابل للتمرير. الجرس في نهاية الصف
/// (يساراً) كما في التصميم.
class HomeGreetingHeader extends StatelessWidget {
  /// التحية العريضة (مثال: `'طاب يومك اسم المستخدم 👋'`).
  final String title;

  /// النص الفرعي الخافت (مثال: `'تقارير أطفالك جاهزة للمراجعة!'`).
  final String subtitle;

  /// عدد التنبيهات على الجرس (0 = بلا شارة).
  final int notificationCount;

  /// يُستدعى عند ضغط الجرس.
  final VoidCallback? onNotifications;

  /// رقاقات التبويبات (`الكل/الاشعارات/اطفالي...`).
  final List<HomeTabChip> tabs;

  /// مؤشر التبويب المحدد.
  final int selectedTab;

  /// يُستدعى بمؤشر التبويب المضغوط.
  final ValueChanged<int>? onTabSelected;

  const HomeGreetingHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.notificationCount = 0,
    this.onNotifications,
    this.tabs = const <HomeTabChip>[],
    this.selectedTab = 0,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    key: const ValueKey('home-header-title'),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.spacing.md.w),
            GestureDetector(
              key: const ValueKey('home-header-bell'),
              onTap: onNotifications,
              behavior: HitTestBehavior.opaque,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: 28.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                  if (notificationCount > 0)
                    PositionedDirectional(
                      top: -4.h,
                      end: -4.w,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onError,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (tabs.isNotEmpty) ...[
          SizedBox(height: context.spacing.md.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < tabs.length; i++) ...[
                  _TabChip(
                    tab: tabs[i],
                    selected: i == selectedTab,
                    onTap: onTabSelected == null
                        ? null
                        : () => onTabSelected!(i),
                  ),
                  if (i < tabs.length - 1)
                    SizedBox(width: context.spacing.sm.w),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// رقاقة تبويب بأيقونة: مملوءة عند التحديد، محايدة otherwise.
class _TabChip extends StatelessWidget {
  final HomeTabChip tab;
  final bool selected;
  final VoidCallback? onTap;

  const _TabChip({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color fg = selected
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.md.w,
          vertical: context.spacing.sm.h,
        ),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.radius.full.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(tab.icon, size: 16.sp, color: fg),
            SizedBox(width: 4.w),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
