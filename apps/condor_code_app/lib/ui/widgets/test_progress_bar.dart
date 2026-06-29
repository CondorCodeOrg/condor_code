import 'package:flutter/material.dart';

import 'package:ui_kit/ui_kit.dart';

class TestProgressBar extends StatelessWidget {
  const TestProgressBar({
    super.key,
    required this.width,
    required this.height,
    required this.progress,
    required this.color,
  });

  final double width;
  final double height;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Container(
          width: width * progress,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.neon,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    ),
  );
}
