import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/widgets/side_panel_screen_widget.dart';
import 'package:condor_code/ui/widgets/sidebar_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

/// Wraps knowledge-base routes with a persistent left rail that collapses
/// to icon-only on narrow screens (YouTube Studio style).
class KnowledgeBaseShell extends StatelessWidget {
  KnowledgeBaseShell({super.key, required this.child});

  final Widget child;

  static BoxDecoration _railDecoration(BuildContext context) => BoxDecoration(
    color: context.colors.scaffoldBackground,
    border: Border(
      right: BorderSide(
        color: context.colors.border.withValues(alpha: 0.45),
        width: 1,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.textPrimary,
      child: SidePanelScreenWidget(
        sidePanelBuilder: (collapsed) => SidePanel(
          collapsed: collapsed,
          expandedWidth: 260,
          collapsedWidth: 72,
          decoration: _railDecoration(context),
          safeArea: true,
          showHeaderDivider: false,
          child: _KnowledgeBaseSideRailContent(collapsed: collapsed),
        ),
        body: child,
        wideBreakpoint: 1024,
        mediumBreakpoint: 0,
        gap: 0,
      ),
    );
  }
}

class _KnowledgeBaseSideRailContent extends StatelessWidget {
  const _KnowledgeBaseSideRailContent({required this.collapsed});

  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final path = GoRouterState.of(context).uri.path;

    final isHome =
        path == RouteConstants.knowledgeBaseHome ||
        path == RouteConstants.knowledgeBase;
    final isRoadmap = path == RouteConstants.knowledgeBaseRoadmap;
    final isLibrary = path == RouteConstants.knowledgeBaseResources;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: collapsed ? 56 : 20),
        _SideNavItem(
          icon: Icons.dashboard_outlined,
          label: l10n.knowledgeBaseNavDashboard,
          selected: isHome,
          collapsed: collapsed,
          onTap: () {
            di<Analytics>().logEvent(AnalyticsEventName.navClick, {
              AnalyticsPropertyName.destination:
                  RouteConstants.knowledgeBaseHome,
            });
            context.go(RouteConstants.knowledgeBaseHome);
          },
        ),
        _SideNavItem(
          icon: Icons.account_tree_outlined,
          label: l10n.knowledgeBaseNavRoadmap,
          selected: isRoadmap,
          collapsed: collapsed,
          onTap: () {
            di<Analytics>().logEvent(AnalyticsEventName.navClick, {
              AnalyticsPropertyName.destination:
                  RouteConstants.knowledgeBaseRoadmap,
            });
            context.go(RouteConstants.knowledgeBaseRoadmap);
          },
        ),
        _SideNavItem(
          icon: Icons.local_library_outlined,
          label: l10n.knowledgeBaseNavLibrary,
          selected: isLibrary,
          collapsed: collapsed,
          onTap: () {
            di<Analytics>().logEvent(AnalyticsEventName.navClick, {
              AnalyticsPropertyName.destination:
                  RouteConstants.knowledgeBaseResources,
            });
            context.go(RouteConstants.knowledgeBaseResources);
          },
        ),
        _SideNavItem(
          icon: Icons.search,
          label: l10n.knowledgeBaseNavSearch,
          selected: false,
          collapsed: collapsed,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.knowledgeBaseSearchSoon)),
            );
          },
        ),
        _ModernNavDivider(collapsed: collapsed),
        Spacer(),
        if (!collapsed)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colors.border.withValues(alpha: 0.6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.knowledgeBase,
                    style: AppTextStyles.caption1.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 10),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: context.colors.accent,
                      foregroundColor: context.colors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      l10n.knowledgeBaseUpgradePro,
                      style: AppTextStyles.caption1.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (collapsed)
          Tooltip(
            message: l10n.knowledgeBaseUpgradePro,
            preferBelow: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.workspace_premium_outlined,
                      size: 22,
                      color: context.colors.accent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 14),
        _ModernNavDivider(collapsed: collapsed),
        const SizedBox(height: 16),
        _SideNavItem(
          icon: Icons.settings_outlined,
          label: l10n.knowledgeBaseSettings,
          selected: false,
          dense: true,
          collapsed: collapsed,
          onTap: () {},
        ),
        _SideNavItem(
          icon: Icons.logout_outlined,
          label: l10n.knowledgeBaseLogout,
          selected: false,
          dense: true,
          collapsed: collapsed,
          onTap: () {},
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _ModernNavDivider extends StatelessWidget {
  const _ModernNavDivider({this.collapsed = false});

  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: collapsed ? 8 : 14),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              context.colors.accent.withValues(alpha: 0.45),
              context.colors.textSecondary.withValues(alpha: 0.55),
              Colors.transparent,
            ],
            stops: const [0, 0.35, 0.65, 1],
          ),
        ),
      ),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  const _SideNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.dense = false,
    this.collapsed = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool dense;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final vertical = dense ? 8.0 : 10.0;

    if (collapsed) {
      return CollapsedSidebarMenuTile(
        variant: CollapsedSidebarMenuVariant.rail,
        tooltipMessage: label,
        isSelected: selected,
        onTap: onTap,
        outerPadding: EdgeInsets.symmetric(horizontal: 4),
        tooltipWaitDuration: Duration(milliseconds: 400),
        squareExtent: null,
        contentPadding: EdgeInsets.symmetric(vertical: vertical),
        child: Icon(
          icon,
          size: 22,
          color: selected ? context.colors.accent : context.colors.textSecondary,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SidebarMenuTile(
        leading: Icon(
          icon,
          size: 22,
          color: selected ? context.colors.accent : context.colors.textSecondary,
        ),
        title: label,
        isSelected: selected,
        onTap: onTap,
        selectionBorderSide: SidebarMenuSelectionBorderSide.end,
        leadingGap: 12,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: vertical,
        ),
        outerPadding: const EdgeInsets.symmetric(vertical: 2),
        titleFontWeightUnselected: FontWeight.w500,
      ),
    );
  }
}
