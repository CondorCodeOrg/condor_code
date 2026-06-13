import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class NavButton extends StatefulWidget {
  const NavButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.route,
  });

  final String title;
  final VoidCallback onTap;
  final String route;

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();

    final bool isActive = currentLocation == widget.route;

    final bool highlight = isActive || isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            widget.title,
            style: AppTextStyles.body1.copyWith(
              color: highlight ? AppColors.white : AppColors.grey200,
            ),
          ),
        ),
      ),
    );
  }
}
