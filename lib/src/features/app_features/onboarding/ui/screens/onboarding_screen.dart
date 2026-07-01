import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:elfulk/src/core/config/routing/routes.dart';
import 'package:elfulk/src/features/app_features/onboarding/logic/cubit/onboarding_cubit.dart';
import 'package:elfulk/src/features/app_features/onboarding/data/view_models/onboarding_page_view_model.dart';
import 'package:elfulk/src/features/app_features/onboarding/ui/widgets/onboarding_page_widget.dart';
import 'package:elfulk/src/features/app_features/onboarding/ui/widgets/onboarding_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;

  final _pages = OnboardingData.pages;

  @override
  void initState() {
    super.initState();

    _controller = PageController();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      _controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      context.read<OnboardingCubit>().onPageChanged(1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    if (_controller.hasClients) {
      _controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) {
        if (curr.currentPage != prev.currentPage) {
          _animateToPage(curr.currentPage);
        }
        return curr.isCompleted && !prev.isCompleted;
      },
      listener: (context, state) {
        context.go(Routes.loginScreen);
      },
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final currentPageData = _pages[state.currentPage];
          final cubit = context.read<OnboardingCubit>();

          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      reverse: true,
                      itemCount: _pages.length,
                      onPageChanged: cubit.onPageChanged,
                      itemBuilder: (context, index) {
                        return OnboardingPageWidget(
                          viewModel: _pages[index],
                          isLogoPage: _pages[index].isLogoPage,
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      24.w,
                      0,
                      24.w,
                      32.h,
                    ),
                    child: Column(
                      children: [
                        if (!currentPageData.isLogoPage)
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: OnboardingIndicator(
                              count: _pages.length - 1,
                              currentIndex: state.currentPage - 1,
                              activeColor: theme.colorScheme.primary,
                            ),
                          ),

                        SizedBox(height: 24.h),

                        if (!currentPageData.isLogoPage)
                          SizedBox(
                            width: double.infinity,
                            height: 42.h,
                            child: ElevatedButton(
                              onPressed: cubit.nextPage,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.chevron_left, size: 20.r),
                                  SizedBox(width: 8.w),
                                  Text(
                                    currentPageData.actionLabel,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!currentPageData.isLogoPage)
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: TextButton(
                              onPressed: cubit.skip,
                              child: Text(
                                'تخطي',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize: 16.sp,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(height: 48.h),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
