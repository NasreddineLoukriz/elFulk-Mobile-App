import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';

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
