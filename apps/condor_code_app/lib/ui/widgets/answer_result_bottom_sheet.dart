import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

enum _AnswerResultVariant { correct, incorrect, mistakesInformation }

class AnswerResultBottomSheet extends StatelessWidget {
  final int? rightAnswerNumber;
  final VoidCallback onButtonPressed;
  final _AnswerResultVariant _variant;

  AnswerResultBottomSheet.correct({
    super.key,
    required this.onButtonPressed,
  }) : rightAnswerNumber = null,
       _variant = _AnswerResultVariant.correct;

  AnswerResultBottomSheet.incorrect({
    super.key,
    required this.onButtonPressed,
    this.rightAnswerNumber,
  }) : _variant = _AnswerResultVariant.incorrect;

  AnswerResultBottomSheet.mistakesInformation({
    super.key,
    required this.onButtonPressed,
  }) : rightAnswerNumber = null,
       _variant = _AnswerResultVariant.mistakesInformation;

  @override
  Widget build(BuildContext context) {
    final (
      Color backgroundColor,
      Color textColor,
      String text,
      ButtonStyle buttonStyle,
      IconData? icon,
    ) = switch (_variant) {
      _AnswerResultVariant.correct => (
        context.colors.surface,
        context.colors.accent,
        'Everything is right, great!',
        AppButtonStyles.mainButtonStyle(context),
        Icons.gpp_good_outlined,
      ),
      _AnswerResultVariant.incorrect => (
        context.colors.surface,
        context.colors.alert,
        'Wrong, correct answer:  $rightAnswerNumber.',
        AppButtonStyles.mainButtonStyle(context),
        Icons.gpp_bad_outlined,
      ),
      _AnswerResultVariant.mistakesInformation => (
        Colors.blue.shade300,
        Colors.indigo.shade900,
        'Now we will work on the mistakes.',
        AppButtonStyles.mainButtonStyle(context),
        null,
      ),
    };

    return Container(
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
            onPressed: onButtonPressed,
            style: buttonStyle,
            child: const Text('MOVE ON', style: AppTextStyles.button),
          ),
        ],
      ),
    );
  }
}
