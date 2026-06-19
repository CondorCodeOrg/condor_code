import 'package:condor_code/ui/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

class AppThemeToggleButton extends StatelessWidget {
  const AppThemeToggleButton({super.key, this.iconSize = 24});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ThemeToggleButton(
          isDarkMode: themeMode == ThemeMode.dark,
          onToggle: () => context.read<ThemeCubit>().toggleTheme(),
          iconSize: iconSize,
        );
      },
    );
  }
}
