import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

import 'package:ui_kit/ui_kit.dart';

class HeartInformationScreen extends StatelessWidget {
  const HeartInformationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.grey800,
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Lottie.asset('assets/animations/sad_smile.json'),
          const Padding(
            padding: EdgeInsets.only(left: 36),
            child: Text(
              'You used all the hearts, watch the video or complete the mini game to earn a heart.',
              style: AppTextStyles.h2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              style: AppButtonStyles.mainButtonStyle,
              child: const Text('MOVE ON', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    ),
  );
}
