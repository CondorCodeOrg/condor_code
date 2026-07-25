import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

enum _AnswerResultVariant { correct, incorrect, mistakesInformation }

class AnswerResultBottomSheet extends StatelessWidget {
  final int? rightAnswerNumber;
  final VoidCallback onButtonPressed;
  final _AnswerResultVariant _variant;

  const AnswerResultBottomSheet.correct({
    super.key,
    required this.onButtonPressed,
  }) : rightAnswerNumber = null,
       _variant = _AnswerResultVariant.correct;

  const AnswerResultBottomSheet.incorrect({
    super.key,
    required this.onButtonPressed,
    this.rightAnswerNumber,
  }) : _variant = _AnswerResultVariant.incorrect;

  const AnswerResultBottomSheet.mistakesInformation({
    super.key,
    required this.onButtonPressed,
  }) : rightAnswerNumber = null,
       _variant = _AnswerResultVariant.mistakesInformation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
        l10n.answerResultCorrect,
        AppButtonStyles.mainButtonStyle(context),
        Icons.gpp_good_outlined,
      ),
      _AnswerResultVariant.incorrect => (
        context.colors.surface,
        context.colors.alert,
        l10n.answerResultIncorrect(rightAnswerNumber ?? 0),
        AppButtonStyles.mainButtonStyle(context),
        Icons.gpp_bad_outlined,
      ),
      _AnswerResultVariant.mistakesInformation => (
        Colors.blue.shade300,
        Colors.indigo.shade900,
        l10n.answerResultMistakesInfo,
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
            child: Text(l10n.moveOn, style: AppTextStyles.button),
          ),
        ],
      ),
    );
  }
}
