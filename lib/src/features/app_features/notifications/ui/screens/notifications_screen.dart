import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_error_card.dart';
import 'package:elfulk/src/core/widgets/app_filter_chip.dart';
import 'package:elfulk/src/core/widgets/app_loading_view.dart';
import 'package:elfulk/src/core/widgets/notification_card.dart';
import 'package:elfulk/src/core/widgets/section_header.dart';
import 'package:elfulk/src/features/app_features/notifications/data/models/notification_item.dart';
import 'package:elfulk/src/features/app_features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:elfulk/src/features/app_features/notifications/logic/notification_actions.dart';

/// شاشة الإشعارات حسب التصميم (عربي RTL، خارج الـ shell بزر رجوع).
///
/// رقاقات فلترة علوية + تجميع زمني (اليوم/البارحة/...) + بطاقات
/// بأفعال حقيقية (قفل/سياسة/PIN/قراءة/تجاهل).
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإشعارات'), centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const AppLoadingView(),
              loading: () => const AppLoadingView(),
              loaded: (items, filter) =>
                  _NotificationsLoaded(items: items, filter: filter),
              error: (error) => AppErrorCard(
                message: error.detail,
                onRetry: () => context.read<NotificationsCubit>().load(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NotificationsLoaded extends StatelessWidget {
  final List<NotificationItem> items;
  final NotificationFilter filter;

  const _NotificationsLoaded({required this.items, required this.filter});

  @override
  Widget build(BuildContext context) {
    final List<String> groups = <String>[];
    for (final NotificationItem item in items) {
      if (!groups.contains(item.group)) groups.add(item.group);
    }

    return ListView(
      padding: context.spacing.pagePadding,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final NotificationFilter f in NotificationFilter.values) ...[
                AppFilterChip(
                  label: f.label,
                  selected: f == filter,
                  onSelected: () =>
                      context.read<NotificationsCubit>().selectFilter(f),
                ),
                SizedBox(width: context.spacing.sm.w),
              ],
            ],
          ),
        ),
        SizedBox(height: context.spacing.md.h),
        for (final String group in groups) ...[
          SectionHeader(title: group),
          SizedBox(height: context.spacing.sm.h),
          for (final NotificationItem item in items.where(
            (i) => i.group == group,
          )) ...[
            NotificationCard(
              childLabel: item.childLabel,
              category: item.category,
              categoryLabel: item.categoryLabel,
              title: item.title,
              body: item.body,
              primaryLabel: item.primaryLabel,
              onPrimary: () => handleNotificationAction(
                context,
                context.read<NotificationsCubit>(),
                item,
                primary: true,
              ),
              secondaryLabel: item.secondaryLabel,
              onSecondary: item.secondaryLabel == null
                  ? null
                  : () => handleNotificationAction(
                      context,
                      context.read<NotificationsCubit>(),
                      item,
                      primary: false,
                    ),
              onDismiss: () =>
                  context.read<NotificationsCubit>().dismiss(item.id),
            ),
            SizedBox(height: context.spacing.md.h),
          ],
        ],
      ],
    );
  }
}
