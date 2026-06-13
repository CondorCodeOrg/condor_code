import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

abstract class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Neutral Face',
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 1.8,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.5,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.5,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.5,
  );

  static const TextStyle body4 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w300,
    fontSize: 14,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.5,
  );

  static const TextStyle caption1 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.0,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.grey200,
  );

  static const TextStyle errorInput = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w200,
    fontSize: 12,
    color: AppColors.alertRed,
  );

  static const TextStyle backgroundHint = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.grey200,
  );

  static const TextStyle code = TextStyle(
    fontFamily: 'monospace',
    fontWeight: FontWeight.w400,
    backgroundColor: Colors.transparent,
    color: AppColors.neon,
  );

  static const TextStyle console = TextStyle(
    color: AppColors.lightGrey,
    fontFamily: 'JetBrainsMono',
    fontSize: 15,
    height: 1.6,
    letterSpacing: 0.3,
  );
}
