import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:elfulk/src/core/helpers/src/assets_path_helper.dart';

class AppScreenTemplate extends StatelessWidget {
  final Widget child;
  final Widget? topWidget;

  const AppScreenTemplate({
    super.key,
    required this.child,
    this.topWidget,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Flexible(
                      flex: isKeyboardOpen ? 0 : 1,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: isKeyboardOpen ? 10.h : 20.h,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: isKeyboardOpen ? 60.h : 110.h,
                          child: topWidget ??
                              SvgPicture.asset(
                                AssetsPathHelper.elFulkLogo,
                              ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        top: 28.h,
                        bottom: 24.h,
                      ),
                      child: child,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
