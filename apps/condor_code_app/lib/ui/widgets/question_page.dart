import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/condor_code_network_image_view.dart';

class QuestionPage extends StatefulWidget {
  final Question question;
  final int questionPosition;
  final Function(int questionPosition, int selectedAnswerNumber)
  onAnswerSelected;

  const QuestionPage({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.questionPosition,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selectedAnswerNumber = 0;

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = widget.question.imageUrl?.isEmpty ?? true
        ? null
        : widget.question.imageUrl;
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20),
            child: Text(widget.question.title, style: AppTextStyles.body2),
          ),
        ),
        const SizedBox(height: 40),
        const SizedBox(width: 20),
        if (imageUrl != null)
          Expanded(child: CCNetworkImageView(imageUrl: imageUrl)),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: getButtonStyle(isSelected: selectedAnswerNumber == 1),
                  onPressed: () {
                    setState(() {
                      selectedAnswerNumber = 1;
                      widget.onAnswerSelected(
                        widget.questionPosition,
                        selectedAnswerNumber,
                      );
                    });
                    //      }
                  },
                  child: Text(
                    widget.question.firstAnswer,
                    style: AppTextStyles.body2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: getButtonStyle(isSelected: selectedAnswerNumber == 2),
                  onPressed: () {
                    setState(() {
                      selectedAnswerNumber = 2;
                      widget.onAnswerSelected(
                        widget.questionPosition,
                        selectedAnswerNumber,
                      );
                    });
                    //    }
                  },
                  child: Text(
                    widget.question.secondAnswer,
                    style: AppTextStyles.body2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: getButtonStyle(isSelected: selectedAnswerNumber == 3),
                  onPressed: () {
                    setState(() {
                      selectedAnswerNumber = 3;
                      widget.onAnswerSelected(
                        widget.questionPosition,
                        selectedAnswerNumber,
                      );
                    });
                  },
                  child: Text(
                    widget.question.thirdAnswer,
                    style: AppTextStyles.body2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ButtonStyle getButtonStyle({required bool isSelected}) => isSelected
      ? AppButtonStyles.selectedTestButton(context)
      : AppButtonStyles.defaultTestButton(context);
}
