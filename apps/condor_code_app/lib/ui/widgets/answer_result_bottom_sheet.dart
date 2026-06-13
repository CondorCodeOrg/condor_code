import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class AnswerResultBottomSheet extends StatelessWidget {
  final int? rightAnswerNumber;
  final Color textColor;
  final Color backgroundColor;
  final String text;
  final VoidCallback onButtonPressed;
  final ButtonStyle? buttonStyle;
  final IconData? icon;

  AnswerResultBottomSheet.correct({super.key, required this.onButtonPressed})
    : //  backgroundColor = Colors.green.shade300,
      backgroundColor = AppColors.grey600,
      text = 'Everything is right, great!',
      buttonStyle = AppButtonStyles.mainButtonStyle,
      rightAnswerNumber = null,
      textColor = AppColors.neon,
      icon = Icons.gpp_good_outlined;

  AnswerResultBottomSheet.incorrect({
    super.key,
    required this.onButtonPressed,
    this.rightAnswerNumber,
  }) : //    backgroundColor = Colors.red.shade200,
       backgroundColor = AppColors.grey600,
       text = 'Wrong, correct answer:  $rightAnswerNumber.',
       buttonStyle = AppButtonStyles.mainButtonStyle,
       textColor = AppColors.alertRed,
       icon = Icons.gpp_bad_outlined;

  AnswerResultBottomSheet.mistakesInformation({
    super.key,
    required this.onButtonPressed,
  }) : backgroundColor = Colors.blue.shade300,
       text = 'Now we will work on the mistakes.',
       buttonStyle = AppButtonStyles.mainButtonStyle,
       rightAnswerNumber = null,
       textColor = Colors.indigo.shade900,
       icon = null;

  @override
  Widget build(BuildContext context) => Container(
    color: backgroundColor,
    height: 150,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(size: 30, icon, color: textColor),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  text,
                  style: AppTextStyles.body2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            onButtonPressed();
          },
          style: buttonStyle,
          child: const Text('MOVE ON', style: AppTextStyles.button),
        ),
      ],
    ),
  );
}
