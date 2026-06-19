import 'package:flutter/material.dart';

import 'package:ui_kit/ui_kit.dart';

class CustomProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final double progress;
  final Color color;
  final int totalNumberOfStages;

  const CustomProgressBar({
    super.key,
    required this.width,
    required this.height,
    required this.progress,
    required this.color,
    required this.totalNumberOfStages,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: context.colors.textSecondary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Container(
          width: (progress * width) / totalNumberOfStages,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            '${progress.toInt()}/$totalNumberOfStages',
            style: AppTextStyles.caption1,
          ),
        ),
      ],
    ),
  );
}
