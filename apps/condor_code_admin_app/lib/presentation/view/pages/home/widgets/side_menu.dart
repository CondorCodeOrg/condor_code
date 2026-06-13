import 'package:condorcode_admin/presentation/enums/admin_section.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.selected, required this.onSelected});

  final AdminSection selected;
  final ValueChanged<AdminSection> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.lightGreenAccent,
                ),
                const SizedBox(width: 8),
                Text(
                  context.strings.adminLabel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
    final labelColor = selected ? Colors.black87 : Colors.grey;
    final bgColor = selected
        ? Colors.lightGreenAccent.withAlpha(50)
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
            color: selected ? Colors.lightGreenAccent : Colors.transparent,
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
