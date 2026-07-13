import 'package:flutter/material.dart';
import 'package:ui_kit/styles/text_styles/app_text_styles.dart';
import 'package:ui_kit/theme/condor_theme_context.dart';

abstract class AppButtonStyles {
  static ButtonStyle mainButtonStyle(BuildContext context) =>
      ElevatedButton.styleFrom(
        backgroundColor: context.colors.accent,
        foregroundColor: context.colors.accentForeground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: AppTextStyles.button,
        disabledBackgroundColor: context.colors.textSecondary,
        disabledForegroundColor: context.colors.surface,
      );

  static ButtonStyle circleButtonStyle(BuildContext context) =>
      ElevatedButton.styleFrom(
        backgroundColor: context.colors.accent,
        foregroundColor: context.colors.accentForeground,
        elevation: 0,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        minimumSize: const Size(40, 40),
        disabledBackgroundColor: context.colors.textSecondary,
        disabledForegroundColor: context.colors.surface,
      );

  static ButtonStyle smallButtonStyle(BuildContext context) =>
      ElevatedButton.styleFrom(
        iconColor: context.colors.textSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      );

  static ButtonStyle defaultTestButton(BuildContext context) =>
      ElevatedButton.styleFrom(
        backgroundColor: context.colors.surface,
        fixedSize: const Size(352, 52),
        side: BorderSide(width: 0.6, color: context.colors.accent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
      );

  static ButtonStyle selectedTestButton(BuildContext context) =>
      ElevatedButton.styleFrom(
        backgroundColor: context.colors.accent,
        fixedSize: const Size(352, 52),
        side: BorderSide(width: 0.9, color: context.colors.accent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
      );
}
