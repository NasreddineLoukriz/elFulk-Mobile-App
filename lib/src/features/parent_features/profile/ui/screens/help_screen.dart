import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';

/// المساعدة والدعم حسب التصميم (عربي RTL).
///
/// بطاقة مجمعة من 5 صفوف (من نحن/تواصل/أسئلة/خصوصية/شروط) تفتح
/// وجهاتها. صف الخصوصية يعرض ورقة السياسة مباشرة.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('المساعدة والدعم'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: [
            _GroupCard(
              children: [
                _menuTile(context, theme,
                    title: 'من نحن',
                    icon: Icons.info_outline_rounded,
                    onTap: () => context.push(Routes.aboutScreen)),
                _menuTile(context, theme,
                    title: 'تواصل معنا',
                    icon: Icons.headset_mic_outlined,
                    onTap: () => context.push(Routes.contactUsScreen)),
                _menuTile(context, theme,
                    title: 'الأسئلة الشائعة',
                    icon: Icons.help_outline_rounded,
                    onTap: () => context.push(Routes.faqScreen)),
                _menuTile(context, theme,
                    title: 'سياسة الخصوصية',
                    icon: Icons.privacy_tip_outlined,
                    onTap: () => context.push(Routes.privacyScreen)),
                _menuTile(context, theme,
                    title: 'الشروط والأحكام',
                    icon: Icons.description_outlined,
                    last: true,
                    onTap: () => context.push(Routes.privacyScreen)),
              ],
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
      leadingBackgroundColor: theme.colorScheme.surfaceContainerHighest,
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
