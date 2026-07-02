import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_section_card.dart';
import 'package:elfulk/src/features/parent_features/parent_home/data/view_models/parent_home_overview_view_model.dart';
import 'package:elfulk/src/features/parent_features/parent_home/logic/cubit/parent_home_cubit.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentHomeCubit, ParentHomeState>(
      builder: (BuildContext context, ParentHomeState state) {
        return state.when(
          initial: () => const _ParentLoadingView(),
          loading: () => const _ParentLoadingView(),
          loaded: (ParentHomeOverviewViewModel overview) =>
              _ParentLoadedView(overview: overview),
          error: (error) => _ParentErrorView(message: error.detail),
        );
      },
    );
  }
}

class _ParentLoadedView extends StatelessWidget {
  const _ParentLoadedView({required this.overview});

  final ParentHomeOverviewViewModel overview;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Parent Features')),
      body: ListView(
        padding: context.spacing.pagePadding,
        children: <Widget>[
          AppSectionCard(
            eyebrow: 'Parent',
            title: overview.title,
            accentColor: const Color(0xFF1D4ED8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(overview.summary, style: theme.textTheme.bodyLarge),
                SizedBox(height: context.spacing.md.h),
                Wrap(
                  spacing: context.spacing.m.w,
                  runSpacing: context.spacing.m.h,
                  children: <Widget>[
                    _InfoChip(label: 'Base URL', value: overview.baseUrl),
                    _InfoChip(label: 'Endpoint', value: overview.endpoint),
                  ],
                ),
                SizedBox(height: context.spacing.md.h),
                FilledButton.tonal(
                  onPressed: () => context.push(Routes.parentRequestsScreen),
                  child: const Text('Open Bloc-based parent requests'),
                ),
              ],
            ),
          ),
          SizedBox(height: context.spacing.l.h),
          AppSectionCard(
            eyebrow: 'Dummy Data',
            title: 'Parent dashboard highlights',
            accentColor: const Color(0xFF0F766E),
            child: Column(
              children: overview.highlights
                  .map(
                    (ParentHighlightViewModel highlight) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: context.spacing.md.h),
                      padding: EdgeInsets.all(context.spacing.l.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF8F3),
                        borderRadius: BorderRadius.circular(
                          context.radius.x3l.r,
                        ),
                        border: Border.all(color: const Color(0xFFE0D7C8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            highlight.value,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: context.spacing.s.h),
                          Text(
                            highlight.label,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: context.spacing.sm.h),
                          Text(
                            highlight.detail,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: context.spacing.l.h),
          AppSectionCard(
            eyebrow: 'Actions',
            title: 'What this feature group can own',
            accentColor: const Color(0xFFB7791F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: overview.nextActions
                  .map(
                    (String action) => Padding(
                      padding: EdgeInsets.only(
                        bottom: context.spacing.sm12.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: context.spacing.sm.w,
                            height: context.spacing.sm.w,
                            margin: EdgeInsets.only(top: context.spacing.s.h),
                            decoration: const BoxDecoration(
                              color: Color(0xFFB7791F),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: context.spacing.sm12.w),
                          Expanded(
                            child: Text(
                              action,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParentLoadingView extends StatelessWidget {
  const _ParentLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ParentErrorView extends StatelessWidget {
  const _ParentErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Features')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.spacing.lg.r),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm12.w,
        vertical: context.spacing.sm.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F5),
        borderRadius: BorderRadius.circular(context.radius.full.r),
      ),
      child: Text('$label: $value'),
    );
  }
}
