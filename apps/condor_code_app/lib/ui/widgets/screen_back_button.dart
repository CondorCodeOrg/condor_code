import 'package:condor_code/ui/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// A styled back-arrow button for screen headers.
class ScreenBackButton extends StatelessWidget {
  const ScreenBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: localization.goBack,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.grey400.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.grey200,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
