import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';
import 'package:elfulk/src/features/parent_features/profile/data/help_content.dart';

/// إعدادات التطبيق حسب التصميم (عربي RTL).
///
/// بطاقة مجمعة (إشعارات/مظهر/لغة) + سطر النسخة. البلاطات شفافة
/// داخل البطاقة بفواصل منقطة.
class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('إعدادات التطبيق'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            _GroupCard(
              children: [
                _menuTile(
                  context,
                  theme,
                  title: 'إدارة الإشعارات',
                  icon: Icons.notifications_outlined,
                  onTap: () => context.push(Routes.notificationsScreen),
                ),
                _menuTile(
                  context,
                  theme,
                  title: 'مظهر التطبيق',
                  icon: Icons.palette_outlined,
                  onTap: () => context.push(Routes.appearanceScreen),
                ),
                _menuTile(
                  context,
                  theme,
                  title: 'اللغة',
                  icon: Icons.language_outlined,
                  last: true,
                  onTap: () => context.push(Routes.languageScreen),
                ),
              ],
            ),
            SizedBox(height: context.spacing.lg.h),
            Center(
              child: Text(
                HelpContent.appVersion,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SettingsListTile _menuTile(
    BuildContext context,
    ThemeData theme, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    bool last = false,
  }) {
    return SettingsListTile(
      title: title,
      leading: Icon(icon),
      leadingBackgroundColor:
          theme.colorScheme.surfaceContainerHighest,
      trailing: const SettingsTileTrailing.chevron(),
      backgroundColor: Colors.transparent,
      borderRadius: 0,
      showDivider: !last,
      dashedDivider: true,
      onTap: onTap,
    );
  }
}

/// بطاقة مجموعة: خلفية وزاوية مستديرة تحتضن صفوفاً شفافة.
class _GroupCard extends StatelessWidget {
  final List<Widget> children;

  const _GroupCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.xxl.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
