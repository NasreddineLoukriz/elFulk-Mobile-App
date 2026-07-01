import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:elfulk/src/features/app_features/onboarding/data/view_models/onboarding_page_view_model.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({
    super.key,
    required this.viewModel,
    required this.isLogoPage,
  });

  final OnboardingPageViewModel viewModel;
  final bool isLogoPage;

  @override
  Widget build(BuildContext context) {
    if (isLogoPage) {
  return Container(
    color: const Color(0xFFF5F0E8),
    child: Center(
      child: SvgPicture.asset(
        viewModel.imagePath,
        width: 256.w,
        height: 186.h,
      ),
    ),
  );
}

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
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
          SizedBox(height: 32.h),
          Text(
            viewModel.title,
            style: TextStyle(
              fontSize: 41.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B3A57),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 12.h),
          Text(
            viewModel.description,
            style: TextStyle(
              fontSize: 16.sp,
              color: Color(0xFF69859D),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}