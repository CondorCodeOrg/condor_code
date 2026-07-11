import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

abstract class AppButtonStyles {
  static ButtonStyle mainButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.neon,
    foregroundColor: AppColors.darkGrey800,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    textStyle: AppTextStyles.button,
    disabledBackgroundColor: AppColors.grey400,
    disabledForegroundColor: AppColors.grey200,
  );

  static ButtonStyle circleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.neon,
    foregroundColor: AppColors.darkGrey800,
    elevation: 0,
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(12),
    minimumSize: const Size(40, 40),
    disabledBackgroundColor: AppColors.grey400,
    disabledForegroundColor: AppColors.grey200,
  );

  static ButtonStyle smallButtonStyle = ElevatedButton.styleFrom(
    iconColor: AppColors.lightGrey,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  );

  static ButtonStyle defaultTestButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.grey600,
    fixedSize: const Size(352, 52),
    side: const BorderSide(width: 0.6, color: AppColors.neon),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
  );

  static ButtonStyle selectedTestButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.neon,
    fixedSize: const Size(352, 52),
    side: const BorderSide(width: 0.9, color: AppColors.neon),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
  );
}
