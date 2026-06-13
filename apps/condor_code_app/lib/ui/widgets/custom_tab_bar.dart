import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    required this.tabController,
    required this.tabs,
    super.key,
  });

  final TabController tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.grey600,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.grey400, width: 0.6),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.neonBlur, width: 1.5),
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.neonBlur,
        unselectedLabelColor: AppColors.lightGrey,
        labelStyle: AppTextStyles.backgroundHint,
        unselectedLabelStyle: AppTextStyles.backgroundHint,
        dividerColor: Colors.transparent,
        tabs: tabs,
      ),
    );
  }
}
