import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_section_card.dart';
import 'package:elfulk/src/features/app_features/architecture/data/view_models/architecture_overview_view_model.dart';
import 'package:elfulk/src/features/app_features/architecture/logic/cubit/architecture_cubit.dart';

class ArchitectureOverviewScreen extends StatelessWidget {
  const ArchitectureOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchitectureCubit, ArchitectureState>(
      builder: (BuildContext context, ArchitectureState state) {
        return state.when(
          initial: () => const _ArchitectureLoadingView(),
          loading: () => const _ArchitectureLoadingView(),
          loaded: (ArchitectureOverviewViewModel overview) =>
              _ArchitectureLoadedView(overview: overview),
          error: (String message) => _ArchitectureErrorView(message: message),
        );
      },
    );
  }
}

class _ArchitectureLoadedView extends StatelessWidget {
  const _ArchitectureLoadedView({required this.overview});

  final ArchitectureOverviewViewModel overview;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Architecture Reference')),
      body: ListView(
        padding: context.spacing.pagePadding,
        children: <Widget>[
          AppSectionCard(
            eyebrow: 'Startup',
            title: 'Boot flow',
            accentColor: const Color(0xFF0F766E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: overview.startupSteps
                  .asMap()
                  .entries
                  .map(
                    (MapEntry<int, String> entry) => Padding(
                      padding: EdgeInsets.only(bottom: context.spacing.sm12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 28.w,
                            height: 28.w,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0F766E),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${entry.key + 1}',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(width: context.spacing.sm12.w),
                          Expanded(
                            child: Text(
                              entry.value,
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
          SizedBox(height: context.spacing.l.h),
          AppSectionCard(
            eyebrow: 'Layers',
            title: 'Responsibilities by layer',
            accentColor: const Color(0xFF10363A),
            child: Column(
              children: overview.layers
                  .map(
                    (ArchitectureLayerViewModel layer) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: context.spacing.md.h),
                      padding: EdgeInsets.all(context.spacing.l.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF8F3),
                        borderRadius: BorderRadius.circular(context.radius.x3l.r),
                        border: Border.all(color: const Color(0xFFE0D7C8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            layer.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: context.spacing.sm.h),
                          Text(
                            layer.responsibility,
                            style: theme.textTheme.bodyLarge,
                          ),
                          SizedBox(height: context.spacing.sm12.h),
                          Wrap(
                            spacing: context.spacing.sm.w,
                            runSpacing: context.spacing.sm.h,
                            children: layer.directories
                                .map(
                                  (String directory) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.spacing.m.w,
                                      vertical: context.spacing.sm.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        context.radius.full.r,
                                      ),
                                      border: Border.all(
                                        color: const Color(0xFFDDD3C4),
                                      ),
                                    ),
                                    child: Text(directory),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: context.spacing.sm12.h),
                          Text(
                            layer.note,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
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
            eyebrow: 'Structure',
            title: 'Target folder map',
            accentColor: const Color(0xFFB7791F),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.spacing.l.r),
              decoration: BoxDecoration(
                color: const Color(0xFF102221),
                borderRadius: BorderRadius.circular(context.radius.x3l.r),
              ),
              child: SelectableText(
                overview.folderTree,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEAF6F3),
                  fontFamily: 'monospace',
                  height: 1.45,
                ),
              ),
            ),
          ),
          SizedBox(height: context.spacing.l.h),
          AppSectionCard(
            eyebrow: 'Patterns',
            title: 'Current implementation patterns',
            accentColor: const Color(0xFF0F766E),
            child: Column(
              children: overview.implementationPatterns
                  .map(
                    (ArchitecturePatternViewModel mapping) => Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: context.spacing.md.h),
                      padding: EdgeInsets.all(context.spacing.l.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F7F5),
                        borderRadius: BorderRadius.circular(context.radius.x3l.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mapping.pattern,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF10363A),
                            ),
                          ),
                          SizedBox(height: context.spacing.m.h),
                          Text(
                            mapping.implementation,
                            style: theme.textTheme.bodyLarge,
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
            eyebrow: 'Next',
            title: 'Implementation sequence',
            accentColor: const Color(0xFF7A4B08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: overview.nextMilestones
                  .map(
                    (String milestone) => Padding(
                      padding: EdgeInsets.only(bottom: context.spacing.sm12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: context.spacing.sm.w,
                            height: context.spacing.sm.w,
                            margin: EdgeInsets.only(top: context.spacing.s.h),
                            decoration: const BoxDecoration(
                              color: Color(0xFF7A4B08),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: context.spacing.sm12.w),
                          Expanded(
                            child: Text(
                              milestone,
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

class _ArchitectureLoadingView extends StatelessWidget {
  const _ArchitectureLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ArchitectureErrorView extends StatelessWidget {
  const _ArchitectureErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Architecture')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.spacing.lg.r),
          child: Text(
            'Failed to load architecture overview.\n$message',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
