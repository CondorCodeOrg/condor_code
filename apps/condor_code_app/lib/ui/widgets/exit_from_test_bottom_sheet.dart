import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';

class ExitFromTestBottomSheet extends StatelessWidget {
  const ExitFromTestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: Container(
            color: AppColors.grey800,
            height: 200,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Lottie.asset(
                    'packages/ui_kit/assets/animations/sad_smile.json',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, bottom: 18),
                  child: Text(
                    l10n.exitTestLossWarning,
                    style: AppTextStyles.caption1,
                  ),
                ),
                ElevatedButton(
                  style: AppButtonStyles.mainButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(l10n.testMoveOn, style: AppTextStyles.button),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: AppButtonStyles.smallButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                    context.pop();
                  },
                  child: Text(
                    l10n.exit,
                    style: const TextStyle(
                      color: AppColors.alertRed,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
