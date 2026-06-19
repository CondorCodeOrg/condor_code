import 'package:condor_code/ui/widgets/app_theme_toggle_button.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;
  final bool? isLeading;
  final bool? isTitleCenter;
  final double? topPadding;
  final bool showThemeToggle;

  const TopNavigationBar({
    super.key,
    required this.text,
    this.actions,
    this.isLeading,
    this.isTitleCenter,
    this.topPadding,
    this.showThemeToggle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => Padding(
    padding: topPadding != null
        ? EdgeInsets.only(top: topPadding!)
        : const EdgeInsets.only(),
    child: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.colors.scaffoldBackground,
      leading: isLeading != false
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 24),
              color: context.colors.textPrimary,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      centerTitle: isTitleCenter ?? true,
      title: Text(
        text,
        style: AppTextStyles.h2.copyWith(color: context.colors.textPrimary),
      ),
      toolbarHeight: MediaQuery.of(context).size.height * 0.10,
      actions: [
        ...?actions,
        if (showThemeToggle) const AppThemeToggleButton(),
      ],
    ),
  );
}
