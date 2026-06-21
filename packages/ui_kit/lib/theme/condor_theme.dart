import 'package:flutter/material.dart';
import 'package:ui_kit/styles/colors/app_colors.dart';
import 'package:ui_kit/styles/text_styles/app_text_styles.dart';
import 'package:ui_kit/theme/condor_theme_colors.dart';
import 'package:ui_kit/theme/fade_only_page_transitions.dart';

ThemeData buildCondorTheme(Brightness brightness) {
  final colors =
      brightness == Brightness.dark ? CondorThemeColors.dark : CondorThemeColors.light;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: colors.scaffoldBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.neon,
      brightness: brightness,
      surface: colors.surface,
      onSurface: colors.textPrimary,
    ),
    dividerColor: colors.divider,
    iconTheme: IconThemeData(color: colors.textPrimary),
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.body1.copyWith(color: colors.textPrimary),
      bodyMedium: AppTextStyles.body2.copyWith(color: colors.textPrimary),
      titleLarge: AppTextStyles.h2.copyWith(color: colors.textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.accent,
        foregroundColor: colors.accentForeground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: AppTextStyles.button,
        disabledBackgroundColor: colors.textSecondary,
        disabledForegroundColor: colors.surface,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: colors.popupSurface,
      surfaceTintColor: Colors.transparent,
      textStyle: AppTextStyles.body2.copyWith(color: colors.textPrimary),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colors.popupSurface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppTextStyles.h2.copyWith(color: colors.textPrimary),
      contentTextStyle: AppTextStyles.body1.copyWith(color: colors.textSecondary),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: colors.scaffoldBackground),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.scaffoldBackground,
      foregroundColor: colors.textPrimary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    extensions: [colors],
    pageTransitionsTheme: fadeOnlyPageTransitionsTheme(),
  );
}
