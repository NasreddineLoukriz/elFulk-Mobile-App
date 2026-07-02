import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/core/config/di/dependency_injection.dart';
import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/core/helpers/src/utils/extension/raduis_extension.dart';
import 'package:elfulk/src/core/helpers/src/utils/extension/spacing_extension.dart';
import 'package:elfulk/src/core/networking/helper/api_constants.dart';
import 'package:elfulk/src/core/widgets/app_section_card.dart';
import 'package:elfulk/src/features/app_features/home/data/view_models/home_overview_view_model.dart';
import 'package:elfulk/src/features/app_features/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return state.when(
          initial: () => const _HomeLoadingView(),
          loading: () => const _HomeLoadingView(),
          loaded: (HomeOverviewViewModel overview) =>
              _HomeLoadedView(overview: overview),
          error: (error) => _HomeErrorView(message: error.detail),
        );
      },
    );
  }
}

class _HomeLoadedView extends StatelessWidget {
  const _HomeLoadedView({required this.overview});

  final HomeOverviewViewModel overview;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final AppEnvironment environment = getIt<AppEnvironment>();

    return Scaffold(
      floatingActionButton: environment.isProduction
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(Routes.devHubScreen),
              icon: const Icon(Icons.developer_mode),
              label: const Text('Dev Hub'),
            ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFF8F4EC), Color(0xFFF0E7D8)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: context.spacing.pagePadding,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(context.spacing.lg.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.radius.x4l.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF10363A),
                      Color(0xFF0F766E),
                      Color(0xFF4D9C90),
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0x300F766E),
                      blurRadius: context.radius.x4l.r,
                      offset: Offset(0, context.spacing.l.h),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacing.sm12,
                        vertical: context.spacing.sm.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(
                          context.radius.full.r,
                        ),
                      ),
                      child: Text(
                        'Flavor: ${environment.apiEnvironmentLabel}',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: context.spacing.l.h),
                    Text(
                      'ElFulk App Features',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: context.spacing.sm12.h),
                    Text(
                      overview.headline,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: const Color(0xFFE8FBF8),
                      ),
                    ),
                    SizedBox(height: context.spacing.sm12.h),
                    Text(
                      overview.summary,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFFE2F5F1),
                      ),
                    ),
                    SizedBox(height: context.spacing.l.h),
                    Wrap(
                      spacing: context.spacing.m.w,
                      runSpacing: context.spacing.m.h,
                      children: <Widget>[
                        FilledButton.tonal(
                          onPressed: () =>
                              context.push(Routes.parentHomeScreen),
                          style: _buttonStyle(context),
                          child: const Text('Open parent example'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => context.push(Routes.loginScreen),
                          style: _buttonStyle(context),
                          child: const Text('Open Auth (Login)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => context.push(
                            '${Routes.otpVerificationScreen}?type=email',
                          ),
                          style: _buttonStyle(context),
                          child: const Text(
                            'Open Auth (OTP Verification template)',
                          ),
                        ),
                        FilledButton.tonal(
                          onPressed: () => context.push(
                            '${Routes.otpVerificationScreen}?type=password',
                          ),
                          style: _buttonStyle(context),
                          child: const Text(
                            'Open Auth (OTP Password Reset template)',
                          ),
                        ),
                        FilledButton.tonal(
                          onPressed: () =>
                              context.push(Routes.parentRequestsScreen),
                          style: _buttonStyle(context),
                          child: const Text('Open parent Bloc example'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => context.push(Routes.childHomeScreen),
                          style: _buttonStyle(context),
                          child: const Text('Open child example'),
                        ),
                        FilledButton.tonal(
                          onPressed: () =>
                              context.push(Routes.architectureScreen),
                          style: _buttonStyle(context),
                          child: const Text('Open architecture'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.spacing.lg.h),
              AppSectionCard(
                eyebrow: 'Networking',
                title: 'Dummy networking wired through the app stack',
                accentColor: const Color(0xFF1D4ED8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      spacing: context.spacing.m.w,
                      runSpacing: context.spacing.m.h,
                      children: <Widget>[
                        _InfoChip(
                          label: 'Resolved base URL',
                          value: apiBaseUrl,
                        ),
                        _InfoChip(
                          label: 'Mocked endpoint',
                          value: overview.endpoint,
                        ),
                      ],
                    ),
                    SizedBox(height: context.spacing.md.h),
                    Text(
                      'Flow: HomeCubit -> HomeRepository -> AppApiService -> DioFactory -> DummyApiInterceptor',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.spacing.l.h),
              AppSectionCard(
                eyebrow: 'Principles',
                title: 'Current implementation principles',
                accentColor: colorScheme.primary,
                child: Wrap(
                  spacing: context.spacing.m.w,
                  runSpacing: context.spacing.m.h,
                  children: overview.principles
                      .map(
                        (String principle) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacing.md.w,
                            vertical: context.spacing.m.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F7F5),
                            borderRadius: BorderRadius.circular(
                              context.radius.full.r,
                            ),
                          ),
                          child: Text(
                            principle,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: const Color(0xFF0F5A56),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: context.spacing.l.h),
              AppSectionCard(
                eyebrow: 'Feature Groups',
                title: 'Scaffolded modules in this repo',
                accentColor: const Color(0xFF0F766E),
                child: Column(
                  children: overview.modules
                      .map(
                        (FeatureModuleViewModel module) =>
                            _ModuleTile(module: module),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: context.spacing.l.h),
              AppSectionCard(
                eyebrow: 'Next',
                title: 'Recommended evolution path',
                accentColor: const Color(0xFFB7791F),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: overview.nextMilestones
                      .map(
                        (String step) => Padding(
                          padding: EdgeInsets.only(
                            bottom: context.spacing.sm12.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: context.spacing.sm.w,
                                height: context.spacing.sm.w,
                                margin: EdgeInsets.only(
                                  top: context.spacing.s.h,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFB7791F),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: context.spacing.sm12.w),
                              Expanded(
                                child: Text(
                                  step,
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
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle(BuildContext context) {
    return FilledButton.styleFrom(
      backgroundColor: Colors.white.withValues(alpha: 0.18),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.l.w,
        vertical: context.spacing.md.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.x2_5l.r),
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({required this.module});

  final FeatureModuleViewModel module;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
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
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  module.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacing.sm12.w,
                  vertical: context.spacing.sm.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(context.radius.full.r),
                ),
                child: Text(
                  module.status,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF246B3D),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacing.m.h),
          Text(module.description, style: theme.textTheme.bodyLarge),
          SizedBox(height: context.spacing.md.h),
          Wrap(
            spacing: context.spacing.sm.w,
            runSpacing: context.spacing.sm.h,
            children: module.folders
                .map(
                  (String folder) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.sm12.w,
                      vertical: context.spacing.sm.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7F5),
                      borderRadius: BorderRadius.circular(
                        context.radius.full.r,
                      ),
                    ),
                    child: Text(
                      folder,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: context.spacing.md.h),
          Text(
            module.nextStep,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF5B554A),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeLoadingView extends StatelessWidget {
  const _HomeLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _HomeErrorView extends StatelessWidget {
  const _HomeErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ElFulk')),
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
