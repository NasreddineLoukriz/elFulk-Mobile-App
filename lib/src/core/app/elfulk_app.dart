import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/core/config/di/dependency_injection.dart';
import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/theme/app_theme.dart';
import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';
import 'package:elfulk/src/core/config/routing/app_router.dart';

class ElFulkApp extends StatelessWidget {
  const ElFulkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppEnvironment environment = getIt<AppEnvironment>();

    return ScreenUtilInit(
      designSize: AppConstants.designSize,
      minTextAdapt: true,
      builder: (_, child) {
        return BlocProvider<ThemeCubit>(
          create: (_) => getIt<ThemeCubit>()..load(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (BuildContext context, ThemeState state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: environment.appName,
                theme: buildLightTheme(),
                darkTheme: buildDarkTheme(),
                themeMode: state.mode,
                routerConfig: AppRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}
