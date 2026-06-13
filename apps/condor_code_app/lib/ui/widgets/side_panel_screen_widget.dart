import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

// ---------------------------------------------------------------------------
// SidePanel
// ---------------------------------------------------------------------------

/// A styled container for side-panel content that knows its own widths
/// and handles header visibility, compact mode, and SafeArea wrapping.
class SidePanel extends StatelessWidget {
  const SidePanel({
    super.key,
    required this.collapsed,
    required this.child,
    this.expandedWidth = 260,
    this.collapsedWidth = 72,
    this.decoration,
    this.header,
    this.compact = false,
    this.safeArea = false,
    this.showHeaderDivider = true,
    this.isLoading = false,
    this.loadingSkeletonName,
  });

  final bool collapsed;
  final Widget child;

  final double expandedWidth;
  final double collapsedWidth;

  /// Custom decoration. When null a default card style is used.
  final BoxDecoration? decoration;

  /// Shown above the content when **not** collapsed.
  final Widget? header;

  /// When true the panel sizes to its content (narrow/scrollable layouts).
  final bool compact;

  final bool safeArea;
  final bool showHeaderDivider;

  /// When true a skeleton shimmer is shown instead of [child].
  final bool isLoading;

  /// Hollow skeleton name used when [isLoading] is true.
  /// Falls back to a generic progress indicator when null.
  final String? loadingSkeletonName;

  double get currentWidth => collapsed ? collapsedWidth : expandedWidth;

  static final _defaultDecoration = BoxDecoration(
    color: AppColors.grey600.withValues(alpha: 0.42),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: AppColors.grey400.withValues(alpha: 0.55)),
  );

  Widget _buildLoadingSkeleton() {
    if (loadingSkeletonName != null) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Skeleton(
          name: loadingSkeletonName,
          loading: true,
          color: AppColors.grey600.withValues(alpha: 0.35),
          highlightColor: AppColors.neon.withValues(alpha: 0.10),
          child: const SizedBox.shrink(),
        ),
      );
    }
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: CircularProgressIndicator(color: AppColors.neon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = isLoading ? _buildLoadingSkeleton() : child;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (header != null && !collapsed) ...[
          header!,
          if (showHeaderDivider)
            const Divider(color: AppColors.grey600, height: 1),
        ],
        if (compact) body else Expanded(child: body),
      ],
    );

    content = Container(
      decoration: decoration ?? _defaultDecoration,
      child: content,
    );

    if (safeArea) content = SafeArea(child: content);

    return content;
  }
}

// ---------------------------------------------------------------------------
// SidePanelHeader
// ---------------------------------------------------------------------------

/// Icon-badge + title row reused across side-panel headers.
class SidePanelHeader extends StatelessWidget {
  const SidePanelHeader({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.neon.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.neon, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SidePanelScreenWidget
// ---------------------------------------------------------------------------

/// Builds a [SidePanel] for the current collapsed state.
typedef SidePanelBuilder = SidePanel Function(bool collapsed);

/// Builds the actions/right-panel content.
/// [isExpanded] is `true` when rendered in the right column (wide layout),
/// `false` when placed below the body (medium layout).
typedef ActionsContentBuilder = Widget Function(bool isExpanded);

/// A responsive three-panel layout with a collapsible left [SidePanel],
/// a central body, and an optional right actions section.
///
/// **Wide** (>= [wideBreakpoint]):
///   `[header?] → Row(sidePanel | body | actionsContent?)`
///
/// **Medium** (>= [mediumBreakpoint]):
///   `[header?] → Row(collapsedSidePanel | body) → actionsContent?`
///
/// **Narrow** (< [mediumBreakpoint]):
///   Delegates to [narrowLayout] if provided; otherwise uses the medium layout.
class SidePanelScreenWidget extends StatelessWidget {
  const SidePanelScreenWidget({
    super.key,
    required this.sidePanelBuilder,
    required this.body,
    this.actionsContentBuilder,
    this.header,
    this.narrowLayout,
    this.actionsContentWidth = 220,
    this.wideBreakpoint = 1100,
    this.mediumBreakpoint = 700,
    this.contentPadding = EdgeInsets.zero,
    this.gap = 16,
  });

  final SidePanelBuilder sidePanelBuilder;
  final Widget body;
  final ActionsContentBuilder? actionsContentBuilder;
  final Widget? header;

  /// Completely custom widget for narrow screens.
  /// When null, the medium layout is used all the way down.
  final Widget? narrowLayout;

  final double actionsContentWidth;
  final double wideBreakpoint;
  final double mediumBreakpoint;
  final EdgeInsets contentPadding;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;

        if (w < mediumBreakpoint && narrowLayout != null) {
          return narrowLayout!;
        }

        final isWide = w >= wideBreakpoint;
        final panel = sidePanelBuilder(!isWide);

        return Padding(
          padding: contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (header != null) ...[header!, SizedBox(height: gap)],
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: panel.currentWidth, child: panel),
                    if (gap > 0) SizedBox(width: gap),
                    Expanded(child: body),
                    if (isWide && actionsContentBuilder != null) ...[
                      if (gap > 0) SizedBox(width: gap),
                      SizedBox(
                        width: actionsContentWidth,
                        child: actionsContentBuilder!(true),
                      ),
                    ],
                  ],
                ),
              ),
              if (!isWide && actionsContentBuilder != null) ...[
                if (gap > 0) SizedBox(height: gap),
                actionsContentBuilder!(false),
              ],
            ],
          ),
        );
      },
    );
  }
}
