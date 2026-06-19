import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ui_kit/ui_kit.dart';

class AchievementCardItem extends StatefulWidget {
  final Achievement achievementData;

  const AchievementCardItem({super.key, required this.achievementData});

  @override
  State<AchievementCardItem> createState() => _AchievementCardItemState();
}

class _AchievementCardItemState extends State<AchievementCardItem> {
  @override
  Widget build(BuildContext context) => GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        color: context.colors.accent,
        border: Border.all(color: context.colors.textSecondary, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(widget.achievementData.image),
        ),
      ),
    ),
  );
}
