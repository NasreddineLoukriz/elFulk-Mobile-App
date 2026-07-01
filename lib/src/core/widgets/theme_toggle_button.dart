import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';

/// A small toggle that cycles the app theme through light → dark → system.
///
/// Place it in an app bar or settings screen.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        final IconData icon = switch (state.mode) {
          ThemeMode.light => Icons.light_mode,
          ThemeMode.dark => Icons.dark_mode,
          ThemeMode.system => Icons.brightness_auto,
        };

        return IconButton(
          icon: Icon(icon),
          tooltip: 'Toggle theme',
          onPressed: () => context.read<ThemeCubit>().toggle(),
        );
      },
    );
  }
}
