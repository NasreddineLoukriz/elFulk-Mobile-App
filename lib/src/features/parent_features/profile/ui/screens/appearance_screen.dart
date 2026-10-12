import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';

/// مظهر التطبيق حسب التصميم (عربي RTL).
///
/// يبدّل ثيم التطبيق الحقيقي عبر `ThemeCubit` الموجود (فاتح/داكن/نظام)
/// — سلوك حقيقي لا عرض فقط.
class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('مظهر التطبيق'), centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return ListView.separated(
              padding: context.spacing.pagePadding,
              itemCount: ThemeMode.values.length,
              separatorBuilder: (context, _) =>
                  SizedBox(height: context.spacing.sm.h),
              itemBuilder: (context, index) {
                final ThemeMode mode = ThemeMode.values[index];
                final bool selected = state.mode == mode;

                return Material(
                  color: theme.cardTheme.color,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(context.radius.xl.r),
                    side: selected
                        ? BorderSide(
                            color: theme.colorScheme.primary,
                            width: 1.5,
                          )
                        : BorderSide.none,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    key: ValueKey('appearance-option-${mode.name}'),
                    leading: Icon(
                      switch (mode) {
                        ThemeMode.light => Icons.light_mode_outlined,
                        ThemeMode.dark => Icons.dark_mode_outlined,
                        ThemeMode.system => Icons.brightness_auto_outlined,
                      },
                      color: theme.colorScheme.primary,
                    ),
                    title: Text(
                      switch (mode) {
                        ThemeMode.light => 'فاتح',
                        ThemeMode.dark => 'داكن',
                        ThemeMode.system => 'حسب النظام',
                      },
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    trailing: selected
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: theme.colorScheme.primary,
                          )
                        : null,
                    onTap: () => context.read<ThemeCubit>().setMode(mode),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
