import 'package:flutter/material.dart';
import 'package:ui_kit/styles/colors/app_colors.dart';

class CondorThemeColors extends ThemeExtension<CondorThemeColors> {
  const CondorThemeColors({
    required this.scaffoldBackground,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.accentForeground,
    required this.border,
    required this.divider,
    required this.alert,
    required this.consoleBackground,
    required this.consoleUserColor,
    required this.popupSurface,
    required this.patternOpacity,
  });

  final Color scaffoldBackground;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color accentForeground;
  final Color border;
  final Color divider;
  final Color alert;
  final Color consoleBackground;
  final Color consoleUserColor;
  final Color popupSurface;
  final double patternOpacity;

  static const dark = CondorThemeColors(
    scaffoldBackground: AppColors.grey800,
    surface: AppColors.grey600,
    textPrimary: AppColors.white,
    textSecondary: AppColors.grey200,
    accent: AppColors.neon,
    accentForeground: AppColors.darkGrey800,
    border: AppColors.grey400,
    divider: AppColors.grey400,
    alert: AppColors.alertRed,
    consoleBackground: AppColors.consoleColor,
    consoleUserColor: AppColors.consoleUserColor,
    popupSurface: AppColors.grey600,
    patternOpacity: 1.0,
  );

  static const light = CondorThemeColors(
    scaffoldBackground: Color(0xFFFAFAFA),
    surface: Color(0xFFF0F0F2),
    textPrimary: AppColors.darkGrey800,
    textSecondary: AppColors.grey200,
    accent: AppColors.neon,
    accentForeground: AppColors.darkGrey800,
    border: Color(0xFFE0E0E3),
    divider: Color(0xFFE8E8EB),
    alert: AppColors.alertRed,
    consoleBackground: Color(0xFFF5F5F5),
    consoleUserColor: AppColors.consoleUserColor,
    popupSurface: AppColors.white,
    patternOpacity: 0.15,
  );

  @override
  CondorThemeColors copyWith({
    Color? scaffoldBackground,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? accentForeground,
    Color? border,
    Color? divider,
    Color? alert,
    Color? consoleBackground,
    Color? consoleUserColor,
    Color? popupSurface,
    double? patternOpacity,
  }) {
    return CondorThemeColors(
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accent: accent ?? this.accent,
      accentForeground: accentForeground ?? this.accentForeground,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      alert: alert ?? this.alert,
      consoleBackground: consoleBackground ?? this.consoleBackground,
      consoleUserColor: consoleUserColor ?? this.consoleUserColor,
      popupSurface: popupSurface ?? this.popupSurface,
      patternOpacity: patternOpacity ?? this.patternOpacity,
    );
  }

  @override
  CondorThemeColors lerp(CondorThemeColors? other, double t) {
    if (other == null) return this;
    return CondorThemeColors(
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentForeground:
          Color.lerp(accentForeground, other.accentForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
      consoleBackground:
          Color.lerp(consoleBackground, other.consoleBackground, t)!,
      consoleUserColor:
          Color.lerp(consoleUserColor, other.consoleUserColor, t)!,
      popupSurface: Color.lerp(popupSurface, other.popupSurface, t)!,
      patternOpacity: patternOpacity + (other.patternOpacity - patternOpacity) * t,
    );
  }
}
