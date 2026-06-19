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
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: context.colors.border, width: 0.6),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: context.colors.accent, width: 1.5),
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: context.colors.accent,
        unselectedLabelColor: context.colors.textSecondary,
        labelStyle: AppTextStyles.backgroundHint,
        unselectedLabelStyle: AppTextStyles.backgroundHint,
        dividerColor: Colors.transparent,
        tabs: tabs,
      ),
    );
  }
}
