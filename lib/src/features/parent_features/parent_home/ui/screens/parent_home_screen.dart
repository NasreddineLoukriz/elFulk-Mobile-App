import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
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
        padding: EdgeInsets.all(20.r),
        children: <Widget>[
          AppSectionCard(
            eyebrow: 'Parent',
            title: overview.title,
            accentColor: const Color(0xFF1D4ED8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(overview.summary, style: theme.textTheme.bodyLarge),
                SizedBox(height: 16.h),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    _InfoChip(label: 'Base URL', value: overview.baseUrl),
                    _InfoChip(label: 'Endpoint', value: overview.endpoint),
                  ],
                ),
                SizedBox(height: 16.h),
                FilledButton.tonal(
                  onPressed: () => context.push(Routes.parentRequestsScreen),
                  child: const Text('Open Bloc-based parent requests'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          AppSectionCard(
            eyebrow: 'Dummy Data',
            title: 'Parent dashboard highlights',
            accentColor: const Color(0xFF0F766E),
            child: Column(
              children: overview.highlights
                  .map(
                    (ParentHighlightViewModel highlight) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 14.h),
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF8F3),
                        borderRadius: BorderRadius.circular(22.r),
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
                          SizedBox(height: 6.h),
                          Text(
                            highlight.label,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
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
          SizedBox(height: 20.h),
          AppSectionCard(
            eyebrow: 'Actions',
            title: 'What this feature group can own',
            accentColor: const Color(0xFFB7791F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: overview.nextActions
                  .map(
                    (String action) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 8.w,
                            height: 8.w,
                            margin: EdgeInsets.only(top: 7.h),
                            decoration: const BoxDecoration(
                              color: Color(0xFFB7791F),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 12.w),
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
          padding: EdgeInsets.all(24.r),
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F5),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text('$label: $value'),
    );
  }
}
