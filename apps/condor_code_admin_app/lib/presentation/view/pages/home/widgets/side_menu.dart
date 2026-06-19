import 'package:condorcode_admin/presentation/enums/admin_section.dart';
import 'package:condorcode_admin/presentation/view/common/widgets/admin_theme_toggle_button.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.selected, required this.onSelected});

  final AdminSection selected;
  final ValueChanged<AdminSection> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: context.colors.scaffoldBackground,
        border: Border(right: BorderSide(color: context.colors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.admin_panel_settings,
                  color: context.colors.accent,
                ),
                const SizedBox(width: 8),
                Text(
                  context.strings.adminLabel,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _SideMenuItem(
            label: context.strings.menuCourses,
            icon: Icons.dashboard_outlined,
            selected: selected == AdminSection.courses,
            onTap: () => onSelected(AdminSection.courses),
          ),
          _SideMenuItem(
            label: context.strings.menuUsers,
            icon: Icons.people_outline,
            selected: selected == AdminSection.users,
            onTap: () => onSelected(AdminSection.users),
          ),
          _SideMenuItem(
            label: context.strings.menuProfile,
            icon: Icons.person_outline,
            selected: selected == AdminSection.profile,
            onTap: () => onSelected(AdminSection.profile),
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.centerRight,
            child: AdminThemeToggleButton(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SideMenuItem extends StatelessWidget {
  const _SideMenuItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelColor =
        selected ? context.colors.textPrimary : context.colors.textSecondary;
    final bgColor = selected
        ? context.colors.accent.withAlpha(50)
        : Colors.transparent;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? context.colors.accent : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: labelColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
