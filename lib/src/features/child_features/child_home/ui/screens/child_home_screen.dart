import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_section_card.dart';
import 'package:elfulk/src/features/child_features/child_home/data/view_models/child_home_overview_view_model.dart';
import 'package:elfulk/src/features/child_features/child_home/logic/cubit/child_home_cubit.dart';

class ChildHomeScreen extends StatelessWidget {
  const ChildHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildHomeCubit, ChildHomeState>(
      builder: (BuildContext context, ChildHomeState state) {
        return state.when(
          initial: () => const _ChildLoadingView(),
          loading: () => const _ChildLoadingView(),
          loaded: (ChildHomeOverviewViewModel overview) =>
              _ChildLoadedView(overview: overview),
          error: (error) => _ChildErrorView(message: error.detail),
        );
      },
    );
  }
}

class _ChildLoadedView extends StatelessWidget {
  const _ChildLoadedView({required this.overview});

  final ChildHomeOverviewViewModel overview;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Child Features')),
      body: ListView(
        padding: context.spacing.pagePadding,
        children: <Widget>[
          AppSectionCard(
            eyebrow: 'Child',
            title: overview.title,
            accentColor: const Color(0xFF7C3AED),
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
              ],
            ),
          ),
          SizedBox(height: context.spacing.l.h),
          AppSectionCard(
            eyebrow: 'Dummy Data',
            title: 'Child tasks loaded through networking',
            accentColor: const Color(0xFF0F766E),
            child: Column(
              children: overview.tasks
                  .map(
                    (ChildTaskViewModel task) => Container(
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  task.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: context.spacing.sm.h),
                                Text(
                                  'Status: ${task.status}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.spacing.m.w,
                              vertical: context.spacing.sm.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F7F5),
                              borderRadius: BorderRadius.circular(
                                context.radius.full.r,
                              ),
                            ),
                            child: Text(task.reward),
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
            eyebrow: 'Tips',
            title: 'How to structure child features',
            accentColor: const Color(0xFFB7791F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: overview.tips
                  .map(
                    (String tip) => Padding(
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
                            child: Text(tip, style: theme.textTheme.bodyLarge),
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

class _ChildLoadingView extends StatelessWidget {
  const _ChildLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ChildErrorView extends StatelessWidget {
  const _ChildErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Child Features')),
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
