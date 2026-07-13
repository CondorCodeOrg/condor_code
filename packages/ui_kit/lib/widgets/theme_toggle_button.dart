import 'package:flutter/material.dart';
import 'package:ui_kit/theme/condor_theme_context.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
    this.iconSize = 24,
  });

  final bool isDarkMode;
  final VoidCallback onToggle;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isDarkMode ? 'Light mode' : 'Dark mode',
      onPressed: onToggle,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: Icon(
          isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDarkMode),
          size: iconSize,
          color: context.colors.textPrimary,
        ),
      ),
    );
  }
}
