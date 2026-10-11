import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';
import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/helpers/show_app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';

class DevHubScreen extends StatelessWidget {
  const DevHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Hub'),
        actions: const <Widget>[_ThemeModeMenu()],
      ),
      body: SafeArea(
        child: ListView(
          padding: context.spacing.pagePadding,
          children: <Widget>[
            _buildHeader(context, theme),
            SizedBox(height: context.spacing.lg.h),
            const _ConfirmationDialogPreview(),
            SizedBox(height: context.spacing.lg.h),
            const _SettingsListTilePreview(),
            SizedBox(height: context.spacing.lg.h),
            ..._buildSections(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacing.lg.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(context.radius.x3l.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'UI Development Hub',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          Text(
            'Tap any route below to preview it. Use the theme menu in the '
            'app bar to switch between light, dark, and system modes.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context, ThemeData theme) {
    final Map<RouteCategory, List<RouteCatalogItem>> grouped =
        <RouteCategory, List<RouteCatalogItem>>{};

    for (final RouteCatalogItem item in Routes.catalog) {
      grouped.putIfAbsent(item.category, () => <RouteCatalogItem>[]).add(item);
    }

    final List<Widget> sections = <Widget>[];
    for (final RouteCategory category in RouteCategory.values) {
      final List<RouteCatalogItem> items =
          grouped[category] ?? <RouteCatalogItem>[];
      if (items.isEmpty) continue;

      sections.add(_RouteCategorySection(category: category, items: items));
      sections.add(SizedBox(height: context.spacing.l.h));
    }

    if (sections.isNotEmpty) {
      sections.removeLast();
    }

    return sections;
  }
}

class _RouteCategorySection extends StatelessWidget {
  const _RouteCategorySection({required this.category, required this.items});

  final RouteCategory category;
  final List<RouteCatalogItem> items;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _categoryLabel(category),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: context.spacing.sm.h),
        Material(
          color: theme.cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radius.x3l.r),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: items.asMap().entries.map((
              MapEntry<int, RouteCatalogItem> entry,
            ) {
              final RouteCatalogItem item = entry.value;
              final bool isLast = entry.key == items.length - 1;

              return Column(
                children: <Widget>[
                  _RouteListTile(item: item),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: context.spacing.lg.w,
                      endIndent: context.spacing.lg.w,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _categoryLabel(RouteCategory category) {
    return switch (category) {
      RouteCategory.screen => 'Screens',
      RouteCategory.dialog => 'Dialogs',
      RouteCategory.bottomSheet => 'Bottom Sheets',
    };
  }
}

class _RouteListTile extends StatelessWidget {
  const _RouteListTile({required this.item});

  final RouteCatalogItem item;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.spacing.lg.w,
        vertical: context.spacing.xs.h,
      ),
      title: Text(
        item.label,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: item.description != null
          ? Padding(
              padding: EdgeInsets.only(top: context.spacing.xs.h),
              child: Text(
                item.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_left,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
      ),
      onTap: () => _navigate(context),
    );
  }

  void _navigate(BuildContext context) {
    final String path = item.queryParameters != null
        ? Uri(path: item.path, queryParameters: item.queryParameters).toString()
        : item.path;

    context.push(path);
  }
}

/// Dev-only preview of the reusable [AppConfirmationDialog].
///
/// Two tiles open the dialog through [showAppConfirmationDialog]: one in
/// [AppConfirmationPrimaryActionType.destructive] mode (slide-to-confirm,
/// Arabic delete-account copy from the design mockup) and one in
/// [AppConfirmationPrimaryActionType.normal] mode. The dialog result
/// (`true` / `false` / `null`) is shown in a [SnackBar] so the full
/// contract can be verified visually in light and dark themes.
class _ConfirmationDialogPreview extends StatelessWidget {
  const _ConfirmationDialogPreview();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirmation Dialog (preview)',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: context.spacing.sm.h),
        Material(
          color: theme.cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radius.x3l.r),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.spacing.lg.w,
                  vertical: context.spacing.xs.h,
                ),
                title: Text(
                  'Delete account (destructive)',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: context.spacing.xs.h),
                  child: Text(
                    'Slide-to-confirm dialog, Arabic copy.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_left,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                onTap: () => _showDestructive(context),
              ),
              Divider(
                height: 1,
                indent: context.spacing.lg.w,
                endIndent: context.spacing.lg.w,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.spacing.lg.w,
                  vertical: context.spacing.xs.h,
                ),
                title: Text(
                  'Sign out (normal)',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: context.spacing.xs.h),
                  child: Text(
                    'Standard filled-button dialog.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_left,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                onTap: () => _showNormal(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showDestructive(BuildContext context) async {
    final bool? result = await showAppConfirmationDialog(
      context: context,
      config: AppConfirmationConfig(
        title: 'هل انت متأكد من حذف الحساب الشخصي ؟',
        message:
            'سيؤدي حذف حسابك إلى إزالة جميع بيانات أطفالك، إعدادات '
            'الحماية، والأجهزة المرتبطة بشكل كامل ونهائي.',
        icon: SvgPicture.asset(AssetsPathHelper.trash),
        primaryActionType: AppConfirmationPrimaryActionType.destructive,
        primaryActionLabel: 'حذف حسابي',
        secondaryActionLabel: 'إلغاء',
        slideTextDirection: TextDirection.rtl,
        thumbIcon: SvgPicture.asset(
          AssetsPathHelper.trash,
          width: 20.w,
          height: 20.h,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        hintIcon: SvgPicture.asset(
          AssetsPathHelper.trash,
          width: 20.w,
          height: 20.h,
        ),
      ),
    );
    if (context.mounted) _showResult(context, result);
  }

  Future<void> _showNormal(BuildContext context) async {
    final bool? result = await showAppConfirmationDialog(
      context: context,
      config: AppConfirmationConfig(
        title: 'تسجيل الخروج؟',
        message: 'سيتم تسجيل خروجك من هذا الجهاز فقط، ويمكنك '
            'تسجيل الدخول مجدداً في أي وقت.',
        icon: SvgPicture.asset(AssetsPathHelper.login),
        primaryActionType: AppConfirmationPrimaryActionType.normal,
        primaryActionLabel: 'تأكيد',
        secondaryActionLabel: 'رجوع',
      ),
    );
    if (context.mounted) _showResult(context, result);
  }

  void _showResult(BuildContext context, bool? result) {
    final String text = switch (result) {
      true => 'Confirmed (true)',
      false => 'Cancelled (false)',
      null => 'Dismissed (null)',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

/// Dev-only preview of the reusable [SettingsListTile].
///
/// Three variants in one card: a destructive red row with subtitle and a
/// green switch (reference copy from the design mockup), a title-only
/// chevron row, and a value row that toggles its text on tap. The switch
/// state lives here (parent-owned state) and taps report via [SnackBar].
class _SettingsListTilePreview extends StatefulWidget {
  const _SettingsListTilePreview();

  @override
  State<_SettingsListTilePreview> createState() =>
      _SettingsListTilePreviewState();
}

class _SettingsListTilePreviewState extends State<_SettingsListTilePreview> {
  bool _alertsEnabled = true;
  String _language = 'العربية';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Settings List Tile (preview)',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: context.spacing.sm.h),
        Material(
          color: theme.cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radius.x3l.r),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: <Widget>[
              SettingsListTile(
                title: 'إشعارات التنبيهات الحرجة.',
                subtitle:
                    'تنبيهك فورًا عند أي محاولة لتجاوز القيود أو العبث '
                    'بإعدادات الحماية.',
                leading: const Icon(Icons.warning_amber_rounded),
                leadingBackgroundColor:
                    theme.colorScheme.error.withValues(alpha: 0.12),
                leadingForegroundColor: theme.colorScheme.error,
                titleColor: theme.colorScheme.error,
                trailing: SettingsTileTrailing.switch_(
                  value: _alertsEnabled,
                  onChanged: (bool value) =>
                      setState(() => _alertsEnabled = value),
                  activeTrackColor: Colors.green,
                ),
                onTap: () => _snack(context, 'alerts row tapped'),
              ),
              SettingsListTile(
                title: 'تغيير اللغة',
                leading: const Icon(Icons.language_outlined),
                trailing: const SettingsTileTrailing.chevron(),
                onTap: () => _snack(context, 'language row tapped'),
              ),
              SettingsListTile(
                title: 'اللغة',
                leading: const Icon(Icons.translate_outlined),
                trailing: SettingsTileTrailing.value(_language),
                showDivider: false,
                onTap: () => setState(
                  () => _language =
                      _language == 'العربية' ? 'English' : 'العربية',
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }

  void _snack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

class _ThemeModeMenu extends StatelessWidget {
  const _ThemeModeMenu();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return PopupMenuButton<ThemeMode>(
          icon: Icon(_iconFor(state.mode)),
          tooltip: 'Theme mode',
          onSelected: (ThemeMode mode) {
            context.read<ThemeCubit>().setMode(mode);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
            _buildItem(ThemeMode.light, 'Light'),
            _buildItem(ThemeMode.dark, 'Dark'),
            _buildItem(ThemeMode.system, 'System'),
          ],
        );
      },
    );
  }

  PopupMenuItem<ThemeMode> _buildItem(ThemeMode mode, String label) {
    return PopupMenuItem<ThemeMode>(
      value: mode,
      child: Row(
        children: <Widget>[
          Icon(_iconFor(mode)),
          SizedBox(width: 12.w),
          Text(label),
        ],
      ),
    );
  }

  IconData _iconFor(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => Icons.light_mode,
      ThemeMode.dark => Icons.dark_mode,
      ThemeMode.system => Icons.brightness_auto,
    };
  }
}
