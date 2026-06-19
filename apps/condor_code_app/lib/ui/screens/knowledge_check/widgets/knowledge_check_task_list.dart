import 'package:condor_code/ui/widgets/sidebar_menu_tile.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Task list content for the knowledge-check side panel.
/// Wrap in [SidePanel] to get the container, header, and collapse behaviour.
class KnowledgeCheckTaskList extends StatelessWidget {
  const KnowledgeCheckTaskList({
    super.key,
    required this.tasks,
    required this.selectedTaskId,
    required this.onTaskSelected,
    this.collapsed = false,
    this.shrinkWrap = false,
  });

  final List<TaskItem> tasks;
  final String? selectedTaskId;
  final ValueChanged<String> onTaskSelected;
  final bool collapsed;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.symmetric(vertical: collapsed ? 4 : 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final isSelected = task.id == selectedTaskId;

        if (collapsed) {
          return CollapsedSidebarMenuTile(
            tooltipMessage: task.name,
            isSelected: isSelected,
            onTap: () => onTaskSelected(task.id),
            child: Text(
              '${index + 1}',
              style: AppTextStyles.body2.copyWith(
                color: isSelected ? context.colors.accent : context.colors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        return SidebarMenuTile(
          leading: SidebarMenuNumberBadge(
            index: index + 1,
            isSelected: isSelected,
          ),
          title: task.name,
          isSelected: isSelected,
          onTap: () => onTaskSelected(task.id),
        );
      },
    );
  }
}
