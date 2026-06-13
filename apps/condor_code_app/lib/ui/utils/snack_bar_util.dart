import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SnackBarUtil {
  static void showSnackBar(BuildContext context, SnackBarEvent event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.grey400,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey200, width: 0.6),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              getIcon(event),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  event.message,
                  style: AppTextStyles.body3.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget getIcon(SnackBarEvent event) => switch (event.type) {
    SnackBarType.info => const Icon(Icons.info),
    SnackBarType.error => SvgPicture.asset(AppIcons.error),
    SnackBarType.success => SvgPicture.asset(AppIcons.success),
  };
}
