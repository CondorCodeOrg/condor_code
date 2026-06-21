import 'package:flutter/material.dart';
import 'package:ui_kit/theme/condor_theme_colors.dart';

extension CondorThemeContext on BuildContext {
  CondorThemeColors get colors =>
      Theme.of(this).extension<CondorThemeColors>() ?? CondorThemeColors.dark;
}
