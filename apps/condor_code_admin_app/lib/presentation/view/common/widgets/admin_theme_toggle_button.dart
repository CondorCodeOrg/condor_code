import 'package:condorcode_admin/presentation/logic/theme/theme_notifier.dart';
import 'package:domain/models/enums/theme_mode.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

class AdminThemeToggleButton extends ConsumerWidget {
  const AdminThemeToggleButton({super.key, this.iconSize = 24});

  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return ThemeToggleButton(
      isDarkMode: themeMode == ThemeMode.dark,
      onToggle: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
      iconSize: iconSize,
    );
  }
}
