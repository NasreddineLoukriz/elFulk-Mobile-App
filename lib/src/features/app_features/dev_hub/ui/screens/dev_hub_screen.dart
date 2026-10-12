import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';
import 'package:elfulk/src/core/widgets/app_badge.dart';
import 'package:elfulk/src/core/widgets/app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/app_dashed_divider.dart';
import 'package:elfulk/src/core/widgets/app_error_card.dart';
import 'package:elfulk/src/core/widgets/app_filter_chip.dart';
import 'package:elfulk/src/core/widgets/app_loading_view.dart';
import 'package:elfulk/src/core/widgets/activity_stats_card.dart';
import 'package:elfulk/src/core/widgets/check_row.dart';
import 'package:elfulk/src/core/widgets/child_card.dart';
import 'package:elfulk/src/core/widgets/device_card.dart';
import 'package:elfulk/src/core/widgets/empty_state.dart';
import 'package:elfulk/src/core/widgets/home_greeting_header.dart';
import 'package:elfulk/src/core/widgets/library_content_row.dart';
import 'package:elfulk/src/core/widgets/notification_card.dart';
import 'package:elfulk/src/core/widgets/parent_bottom_nav.dart';
import 'package:elfulk/src/core/widgets/section_header.dart';
import 'package:elfulk/src/core/widgets/helpers/show_app_confirmation_dialog.dart';
import 'package:elfulk/src/core/widgets/settings_list_tile.dart';
import 'package:elfulk/src/core/widgets/stat_cell.dart';
import 'package:elfulk/src/core/widgets/user_header_card.dart';

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
            const _FoundationPreview(),
            SizedBox(height: context.spacing.lg.h),
            const _P1Preview(),
            SizedBox(height: context.spacing.lg.h),
            const _P2Preview(),
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
/// A mini settings page mirroring the reference design: section headers
/// (plain text — a future `SettingsSectionHeader` widget is out of scope)
/// plus one self-carded tile per section entry. Covers the switch with
/// dynamic description, chevron and value variants. Parent-owned state
/// and taps report via [SnackBar].
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
          _sectionHeader(context, theme, 'كل الإشعارات'),
          SizedBox(height: context.spacing.sm.h),
          SettingsListTile(
            title: 'أرغب في تلقي الإشعارات.',
            leading: Icon(
              Icons.notifications_outlined,
              color: theme.colorScheme.primary,
            ),
            trailing: SettingsTileTrailing.switch_(
              value: _alertsEnabled,
              onChanged: (bool value) =>
                  setState(() => _alertsEnabled = value),
            ),
            showDivider: false,
            onTap: () => _snack(context, 'all notifications tapped'),
          ),
          SizedBox(height: context.spacing.md.h),
          _sectionHeader(context, theme, 'تخصيص الإشعارات'),
          SizedBox(height: context.spacing.sm.h),
          SettingsListTile(
            title: 'إشعارات التنبيهات الحرجة.',
            // وصف اختياري يشرح فائدة التفعيل/الإلغاء ويتبدل مع الحالة.
            subtitle: _alertsEnabled
                ? 'تنبيهك فورًا عند أي محاولة لتجاوز القيود أو العبث '
                    'بإعدادات الحماية.'
                : 'التنبيهات متوقفة. فعّلها لتصلك إشعارات فورية عند '
                    'أي محاولة عبث بالحماية.',
            // شارة دائرية وردية بداخلها "!" حمراء كما في التصميم
            // (بلا حاوية مربعة).
            leading: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.error.withValues(alpha: 0.35),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.priority_high_rounded,
                  size: 14.sp,
                  color: theme.colorScheme.error,
                ),
              ),
            ),
            trailing: SettingsTileTrailing.switch_(
              value: _alertsEnabled,
              onChanged: (bool value) =>
                  setState(() => _alertsEnabled = value),
            ),
            showDivider: false,
            onTap: () => _snack(context, 'alerts row tapped'),
          ),
          SizedBox(height: context.spacing.sm.h),

          SettingsListTile(title:   "اهلا بك في تطبيقنا", leading: Icon(Icons.info_outline, color: theme.colorScheme.primary,), trailing: const SettingsTileTrailing.chevron(), showDivider: false, onTap: () => _snack(context, 'info row tapped'),),
          SizedBox(height: context.spacing.sm.h),
          SettingsListTile(
            title: 'اللغة',
            leading: Icon(
              Icons.translate_outlined,
              color: theme.colorScheme.primary,
            ),
            trailing: SettingsTileTrailing.value(_language),
            showDivider: false,
            onTap: () => setState(
              () => _language =
                  _language == 'العربية' ? 'English' : 'العربية',
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, ThemeData theme, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.md.w),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color:
                  theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ) ??
            TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color:
                  theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
      ),
    );
  }

  void _snack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

/// Dev-only preview of the P0 foundation widgets.
///
/// One section: live [ParentBottomNav], [SectionHeader] (plain + with
/// action), selectable [AppFilterChip]s, [AppBadge] variants, plus the
/// [EmptyState] / [AppErrorCard] / [AppLoadingView] states. Interactive
/// parts report via [SnackBar].
class _FoundationPreview extends StatefulWidget {
  const _FoundationPreview();

  @override
  State<_FoundationPreview> createState() => _FoundationPreviewState();
}

class _FoundationPreviewState extends State<_FoundationPreview> {
  int _navIndex = 3;
  String _selectedChip = 'الكل';

  static const List<String> _chips = <String>['الكل', 'التنبيهات', 'الوقت'];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Foundation (preview)',
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
          child: ParentBottomNav(
            currentIndex: _navIndex,
            onTap: (int index) {
              setState(() => _navIndex = index);
              _snack(context, 'nav tapped: $index');
            },
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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.spacing.md.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SectionHeader(title: 'كل الإشعارات'),
                SizedBox(height: context.spacing.sm.h),
                SectionHeader(
                  title: 'تخصيص الإشعارات',
                  action: TextButton(
                    onPressed: () => _snack(context, 'header action tapped'),
                    child: const Text('عرض الكل'),
                  ),
                ),
                SizedBox(height: context.spacing.sm.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.md.w,
                  ),
                  child: Row(
                    children: <Widget>[
                      for (final String chip in _chips) ...[
                        AppFilterChip(
                          label: chip,
                          selected: _selectedChip == chip,
                          onSelected: () {
                            setState(() => _selectedChip = chip);
                            _snack(context, 'chip: $chip');
                          },
                        ),
                        SizedBox(width: context.spacing.sm.w),
                      ],
                      const AppBadge(label: '01'),
                      SizedBox(width: context.spacing.sm.w),
                      AppBadge(
                        label: '16:00',
                        color: theme.colorScheme.error,
                      ),
                      SizedBox(width: context.spacing.sm.w),
                      const AppBadge(
                        label: 'جديد',
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.spacing.sm.h),
                const EmptyState(
                  icon: Icons.notifications_none,
                  title: 'لا توجد إشعارات',
                  message: 'ستظهر هنا عند وصول جديد.',
                ),
                AppErrorCard(
                  message: 'تعذر تحميل البيانات.',
                  onRetry: () => _snack(context, 'retry tapped'),
                ),
                const AppLoadingView(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _snack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

/// Dev-only preview of the P1 widgets (Home dashboard + notifications).
///
/// One sample per widget with the reference Arabic copy: greeting header
/// with tabs, notification card (dismiss actually removes it), child
/// card, activity stats, device card and a library section. Taps report
/// via [SnackBar]. Full screens stay reachable through the route catalog
/// below (Home, Parent Home, Notifications).
class _P1Preview extends StatefulWidget {
  const _P1Preview();

  @override
  State<_P1Preview> createState() => _P1PreviewState();
}

class _P1PreviewState extends State<_P1Preview> {
  int _tab = 0;
  bool _showCard = true;

  static const List<HomeTabChip> _tabs = <HomeTabChip>[
    HomeTabChip(label: 'الكل', icon: Icons.grid_view_rounded),
    HomeTabChip(label: 'الاشعارات', icon: Icons.notifications_outlined),
    HomeTabChip(label: 'اطفالي', icon: Icons.people_outline_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'P1 Home + Notifications (preview)',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          HomeGreetingHeader(
            title: 'طاب يومك اسم المستخدم 👋',
            subtitle: 'تقارير أطفالك جاهزة للمراجعة!',
            notificationCount: 9,
            onNotifications: () => _snack(context, 'bell tapped'),
            tabs: _tabs,
            selectedTab: _tab,
            onTabSelected: (int i) => setState(() => _tab = i),
          ),
          SizedBox(height: context.spacing.md.h),
          if (_showCard)
            NotificationCard(
              childLabel: 'أنس مالك',
              category: NotificationCategory.alerts,
              categoryLabel: 'التنبيهات',
              title: 'تجاوز الحد الصحي الموصى به',
              body:
                  'تجاوز إجمالي وقت شاشة طفلك اليوم الحد الصحي الموصى به لفئته العمرية.',
              primaryLabel: 'قفل الجهاز فوراً',
              onPrimary: () => _snack(context, 'lock tapped'),
              secondaryLabel: 'مراجعة التفاصيل',
              onSecondary: () => _snack(context, 'details tapped'),
              onDismiss: () => setState(() => _showCard = false),
            ),
          SizedBox(height: context.spacing.md.h),
          ChildCard(
            name: 'أنس مالك',
            usagePrefix: 'مدة الاستخدام اليوم:',
            usageValue: '2 ساعات و 10 دقائق.',
            stats: [
              ChildStat(
                label: 'العمر',
                value: '08 سنوات',
                valueColor: theme.colorScheme.primary,
              ),
              const ChildStat(label: 'الجنس', value: 'ذكر'),
              const ChildStat(
                label: 'التنبيهات المعلقة',
                value: '01 تنبيه',
                valueColor: Color(0xFFF59E0B),
              ),
            ],
            actionLabel: 'الانتقال إلى وجهته الخاصة',
            onAction: () => _snack(context, 'child action tapped'),
            onMenu: () => _snack(context, 'child menu tapped'),
          ),
          SizedBox(height: context.spacing.md.h),
          AddChildDashedCard(
            label: 'إضافة طفل جديد',
            onTap: () => _snack(context, 'add child tapped'),
          ),
          SizedBox(height: context.spacing.md.h),
          ActivityStatsCard(
            title: 'بعض بيانات النشاط داخل المنصة بأطفالك',
            childLabel: 'أنس مالك',
            allowedLine: 'المدة المسموح بها: 2 ساعات و 30 دقيقة.',
            remainingLine:
                'الوقت المتبقي من المدة المسموح بها هو: 27 دقيقة.',
            progress: 0.85,
            progressStartLabel: '0% من الوقت',
            progressEndLabel: '100% من الوقت',
            categories: const [
              ActivityCategory(
                  label: 'الفيديوهات',
                  fraction: 0.6,
                  percentLabel: '60% من الوقت'),
              ActivityCategory(
                  label: 'القصص',
                  fraction: 0.3,
                  percentLabel: '30% من الوقت'),
              ActivityCategory(
                  label: 'الألعاب',
                  fraction: 0.1,
                  percentLabel: '10% من الوقت'),
            ],
            actionLabel: 'عرض تقرير النشاط كامل',
            onAction: () => _snack(context, 'report tapped'),
          ),
          SizedBox(height: context.spacing.md.h),
          DeviceCard(
            deviceName: 'اسم الجهاز',
            userName: 'المستخدم أحمد محسن.',
            statusLabel: 'الحالة',
            statusValue: 'نشط حاليا',
            usageLabel: 'مدة الاستخدام',
            usageValue: '03 س و 10 د',
            enrolledLabel: 'تاريخ التسجيل',
            enrolledValue: '30 أكتوبر 2026',
            onLock: () => _snack(context, 'lock tapped'),
            onPause: () => _snack(context, 'pause tapped'),
            onEdit: () => _snack(context, 'edit tapped'),
          ),
          SizedBox(height: context.spacing.md.h),
          const LibrarySection(
            title: 'اضيفة فيديوهات جديدة مقترحة من فريقنا لمكتبة',
            childLabel: 'أنس مالك',
            rows: [
              LibraryContentRow(
                title: 'الأرنب السريع وأصدقاء الغابة.',
                tags: ['تربية وقيم', 'علوم وتعليم'],
                badge: '15:12',
              ),
            ],
            actionLabel: 'عرض كامل مكتبة فيديوهات طفلك',
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

/// Dev-only preview of the P2 profile widgets.
///
/// User header card, interactive check row and dashed divider samples.
/// The 13 full P2 screens stay reachable through the route catalog
/// below (Profile, App Settings, Account Settings, Edit Info, Change
/// Password, Contact, Help + subpages, Devices).
class _P2Preview extends StatefulWidget {
  const _P2Preview();

  @override
  State<_P2Preview> createState() => _P2PreviewState();
}

class _P2PreviewState extends State<_P2Preview> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'P2 Profile (preview)',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: context.spacing.sm.h),
          const UserHeaderCard(
            name: 'اسم المستخدم',
            email: 'example123@gmail.com',
            stats: [
              StatData(
                  label: 'عدد الأطفال',
                  value: '3 أطفال',
                  valueColor: Color(0xFF2E8C84)),
              StatData(
                  label: 'الأجهزة المرتبطة',
                  value: '3 أجهزة',
                  valueColor: Color(0xFF2E8C84)),
              StatData(
                  label: 'التنبيهات المعلقة',
                  value: '3 تنبيهات',
                  valueColor: Color(0xFFF59E0B)),
            ],
          ),
          SizedBox(height: context.spacing.sm.h),
          CheckRow(
            label: 'أوافق على شروط الاستخدام وسياسة الخصوصية.',
            value: _agreed,
            onChanged: (bool v) => setState(() => _agreed = v),
          ),
          SizedBox(height: context.spacing.sm.h),
          const AppDashedDivider(),
          SizedBox(height: context.spacing.sm.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatCell(label: 'العمر', value: '08 سنوات'),
              StatCell(label: 'الجنس', value: 'ذكر'),
            ],
          ),
        ],
      ),
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
