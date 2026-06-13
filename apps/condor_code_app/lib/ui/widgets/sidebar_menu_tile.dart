import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Which edge shows the neon selection bar (uses [BorderDirectional] for RTL).
enum SidebarMenuSelectionBorderSide { start, end }

/// Sidebar row: optional leading, title, optional subtitle, ink well + selection chrome.
class SidebarMenuTile extends StatelessWidget {
  const SidebarMenuTile({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.selectionBorderSide = SidebarMenuSelectionBorderSide.start,
    this.leadingGap = 10,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 10,
    ),
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.titleFontWeightUnselected = FontWeight.w400,
  });

  final Widget leading;
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final SidebarMenuSelectionBorderSide selectionBorderSide;
  final double leadingGap;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry outerPadding;
  final FontWeight titleFontWeightUnselected;

  @override
  Widget build(BuildContext context) {
    final subtitleText = subtitle?.trim();
    final hasSubtitle = subtitleText != null && subtitleText.isNotEmpty;

    final border = isSelected
        ? BorderDirectional(
            start: selectionBorderSide == SidebarMenuSelectionBorderSide.start
                ? const BorderSide(color: AppColors.neon, width: 3)
                : BorderSide.none,
            end: selectionBorderSide == SidebarMenuSelectionBorderSide.end
                ? const BorderSide(color: AppColors.neon, width: 3)
                : BorderSide.none,
          )
        : null;

    return Padding(
      padding: outerPadding,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: contentPadding,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.grey600.withValues(alpha: 0.85)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: border,
            ),
            child: Row(
              children: [
                leading,
                SizedBox(width: leadingGap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.white,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : titleFontWeightUnselected,
                        ),
                      ),
                      if (hasSubtitle) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitleText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption1.copyWith(
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Number badge used as [SidebarMenuTile.leading] (e.g. lesson index).
class SidebarMenuNumberBadge extends StatelessWidget {
  const SidebarMenuNumberBadge({
    super.key,
    required this.index,
    required this.isSelected,
  });

  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.neon.withValues(alpha: 0.2)
            : AppColors.grey400.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$index',
        style: AppTextStyles.caption1.copyWith(
          color: isSelected ? AppColors.neon : AppColors.lightGrey,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Visual style for [CollapsedSidebarMenuTile] selection chrome.
enum CollapsedSidebarMenuVariant {
  /// Neon fill + full border (e.g. lesson index strip).
  lessonIndex,

  /// Grey fill + trailing selection bar (e.g. knowledge base rail, collapsed).
  rail,
}

/// Compact square or padded strip tile with tooltip — collapsed sidebar entries.
class CollapsedSidebarMenuTile extends StatelessWidget {
  const CollapsedSidebarMenuTile({
    super.key,
    required this.child,
    required this.tooltipMessage,
    required this.isSelected,
    required this.onTap,
    this.variant = CollapsedSidebarMenuVariant.lessonIndex,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    this.tooltipWaitDuration = const Duration(milliseconds: 300),

    /// When non-null, the ink target is a fixed square (e.g. 44 for lessons).
    this.squareExtent = 44,

    /// Used when [squareExtent] is null (e.g. rail icons with vertical padding).
    this.contentPadding = EdgeInsets.zero,
  });

  final Widget child;
  final String tooltipMessage;
  final bool isSelected;
  final VoidCallback onTap;
  final CollapsedSidebarMenuVariant variant;
  final EdgeInsetsGeometry outerPadding;
  final Duration tooltipWaitDuration;
  final double? squareExtent;
  final EdgeInsetsGeometry contentPadding;

  BoxDecoration _decoration() {
    switch (variant) {
      case CollapsedSidebarMenuVariant.lessonIndex:
        return BoxDecoration(
          color: isSelected
              ? AppColors.neon.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: AppColors.neon, width: 2)
              : null,
        );
      case CollapsedSidebarMenuVariant.rail:
        return BoxDecoration(
          color: isSelected
              ? AppColors.grey600.withValues(alpha: 0.85)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? const BorderDirectional(
                  end: BorderSide(color: AppColors.neon, width: 3),
                )
              : null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final inner = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          width: squareExtent,
          height: squareExtent,
          padding: contentPadding,
          alignment: squareExtent != null ? Alignment.center : null,
          decoration: _decoration(),
          child: squareExtent != null ? child : Center(child: child),
        ),
      ),
    );

    return Padding(
      padding: outerPadding,
      child: Tooltip(
        message: tooltipMessage,
        preferBelow: false,
        waitDuration: tooltipWaitDuration,
        child: inner,
      ),
    );
  }
}
