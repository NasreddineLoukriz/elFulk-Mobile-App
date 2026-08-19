import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/features/app_features/onboarding/data/view_models/onboarding_page_view_model.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({
    super.key,
    required this.viewModel,
  });

  final OnboardingPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

 

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.lg.w),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Image.asset(
                    viewModel.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: context.spacing.xl.h),
                Text(
                  viewModel.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 41.sp,
                        fontWeight: FontWeight.w700,
                      ) ??
                      TextStyle(
                        fontSize: 41.sp,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: context.spacing.sm12.h),
                Text(
                  viewModel.description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 16.sp,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        height: 1.6,
                      ) ??
                      TextStyle(
                        fontSize: 16.sp,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        height: 1.6,
                      ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: context.spacing.xl.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
