import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExitFromlessonBottomSheet extends StatelessWidget {
  const ExitFromlessonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: Container(
          color: context.colors.scaffoldBackground,
          height: 200,
          child: Column(
            children: <Widget>[
              Expanded(child: Lottie.asset('assets/animations/sad_smile.json')),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 20, bottom: 18),
                child: Text(
                  'If you leave you will lose all the points you earned during the lesson!',
                  style: AppTextStyles.caption1,
                ),
              ),
              ElevatedButton(
                style: AppButtonStyles.mainButtonStyle(context),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('MOVE ON', style: AppTextStyles.button),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: AppButtonStyles.smallButtonStyle(context),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'EXIT',
                  style: TextStyle(
                    color: context.colors.alert,
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
