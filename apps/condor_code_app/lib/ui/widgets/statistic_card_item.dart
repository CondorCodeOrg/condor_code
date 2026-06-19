import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ui_kit/ui_kit.dart';

class StatisticCardItem extends StatefulWidget {
  final Statistic statisticData;

  const StatisticCardItem({super.key, required this.statisticData});

  @override
  State<StatisticCardItem> createState() => _ShopCardItemState();
}

class _ShopCardItemState extends State<StatisticCardItem> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(8),
    child: Container(
      decoration: BoxDecoration(
        color: context.colors.accent,
        border: Border.all(color: context.colors.textSecondary, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: SvgPicture.asset(widget.statisticData.image),
                ),
              ),
              Text(widget.statisticData.value, style: AppTextStyles.body2),
            ],
          ),
          Text(widget.statisticData.description, style: AppTextStyles.body3),
        ],
      ),
    ),
  );
}
