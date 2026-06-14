import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class ExitFromTestBottomSheet extends StatelessWidget {
  const ExitFromTestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: Container(
          color: AppColors.grey800,
          height: 200,
          child: Column(
            children: <Widget>[
              Expanded(child: Lottie.asset('assets/animations/sad_smile.json')),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 20, bottom: 18),
                child: Text(
                  'If you leave you will lose all the points you earned during the test!',
                  style: AppTextStyles.caption1,
                ),
              ),
              ElevatedButton(
                style: AppButtonStyles.mainButtonStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('MOVE ON', style: AppTextStyles.button),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: AppButtonStyles.smallButtonStyle,
                onPressed: () {
                  Navigator.pop(context);
                  context.pop();
                },
                child: const Text(
                  'EXIT',
                  style: TextStyle(
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
