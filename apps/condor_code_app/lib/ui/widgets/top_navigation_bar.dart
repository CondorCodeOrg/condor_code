import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;
  final bool? isLeading;
  final bool? isTitleCenter;
  final double? topPadding;

  const TopNavigationBar({
    super.key,
    required this.text,
    this.actions,
    this.isLeading,
    this.isTitleCenter,
    this.topPadding,
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
      backgroundColor: AppColors.grey800,
      leading: isLeading != false
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 24),
              color: AppColors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      centerTitle: isTitleCenter ?? true,
      title: Text(
        text,
        style: AppTextStyles.h2.copyWith(color: AppColors.white),
      ),
      toolbarHeight: MediaQuery.of(context).size.height * 0.10,
      actions: actions,
    ),
  );
}
