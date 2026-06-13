import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/screens/knowledge_base/roadmap/cubit/knowledge_base_roadmap_cubit.dart';
import 'package:condor_code/ui/screens/knowledge_base/roadmap/cubit/knowledge_base_roadmap_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/GraphView.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/markdown.dart';

class KnowledgeBaseRoadmapScreen extends StatelessWidget {
  const KnowledgeBaseRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<KnowledgeBaseRoadmapCubit>(),
      child: const _KnowledgeBaseRoadmapView(),
    );
  }
}

class _KnowledgeBaseRoadmapView extends StatefulWidget {
  const _KnowledgeBaseRoadmapView();

  @override
  State<_KnowledgeBaseRoadmapView> createState() =>
      _KnowledgeBaseRoadmapViewState();
}

class _KnowledgeBaseRoadmapViewState extends State<_KnowledgeBaseRoadmapView> {
  final ValueNotifier<KnowledgeBaseRoadmapNode?> _selectedNodeNotifier =
      ValueNotifier<KnowledgeBaseRoadmapNode?>(null);

  @override
  void dispose() {
    _selectedNodeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkGrey800,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _RoadmapHeader(l10n: l10n),
              const SizedBox(height: 12),
              Expanded(
                child:
                    BlocBuilder<
                      KnowledgeBaseRoadmapCubit,
                      KnowledgeBaseRoadmapState
                    >(
                      builder: (context, state) {
                        if (state.isLoading && state.roadmap == null) {
                          if (width > 1272) {
                            return Center(
                              child: Skeleton(
                                name: CondorHollowSkeletonIds
                                    .roadmapMainFullScreen,
                                loading: true,
                                color: AppColors.grey600.withValues(
                                  alpha: 0.35,
                                ),
                                highlightColor: AppColors.neon.withValues(
                                  alpha: 0.12,
                                ),
                                child: const SizedBox.shrink(),
                              ),
                            );
                          }
                          return Center(
                            child: Skeleton(
                              name: CondorHollowSkeletonIds
                                  .roadmapMainMiddleScreen,
                              loading: true,
                              color: AppColors.grey600.withValues(alpha: 0.35),
                              highlightColor: AppColors.neon.withValues(
                                alpha: 0.12,
                              ),
                              child: const SizedBox.shrink(),
                            ),
                          );
                        }

                        final roadmap = state.roadmap;
                        if (roadmap == null) {
                          return Center(
                            child: Text(
                              l10n.knowledgeBaseRoadmapPlaceholder,
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.grey200,
                              ),
                            ),
                          );
                        }

                        return _RoadmapSplitView(
                          roadmap: roadmap,
                          fallbackNode: roadmap.nodes[roadmap.rootId]!,
                          selectedNodeListenable: _selectedNodeNotifier,
                          onSelectNodeInfo: (node) {
                            if (_selectedNodeNotifier.value?.id != node.id) {
                              _selectedNodeNotifier.value = node;
                            }
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoadmapSplitView extends StatelessWidget {
  const _RoadmapSplitView({
    required this.roadmap,
    required this.fallbackNode,
    required this.selectedNodeListenable,
    required this.onSelectNodeInfo,
  });

  final KnowledgeBaseRoadmapData roadmap;
  final KnowledgeBaseRoadmapNode fallbackNode;
  final ValueListenable<KnowledgeBaseRoadmapNode?> selectedNodeListenable;
  final ValueChanged<KnowledgeBaseRoadmapNode> onSelectNodeInfo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 980) {
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: _RoadmapGraph(
                  roadmap: roadmap,
                  onSelectNodeInfo: onSelectNodeInfo,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                flex: 2,
                child: _RoadmapInfoPanel(
                  fallbackNode: fallbackNode,
                  selectedNodeListenable: selectedNodeListenable,
                ),
              ),
            ],
          );
        }
        return Row(
          children: [
            Expanded(
              flex: 7,
              child: _RoadmapGraph(
                roadmap: roadmap,
                onSelectNodeInfo: onSelectNodeInfo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: _RoadmapInfoPanel(
                fallbackNode: fallbackNode,
                selectedNodeListenable: selectedNodeListenable,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RoadmapGraph extends StatefulWidget {
  const _RoadmapGraph({required this.roadmap, required this.onSelectNodeInfo});

  final KnowledgeBaseRoadmapData roadmap;
  final ValueChanged<KnowledgeBaseRoadmapNode> onSelectNodeInfo;

  @override
  State<_RoadmapGraph> createState() => _RoadmapGraphState();
}

class _RoadmapGraphState extends State<_RoadmapGraph> {
  late Graph _graph;
  late GraphViewController _controller;
  late BuchheimWalkerConfiguration _layoutConfig;
  late Map<String, Node> _nodes;

  // Per-node collapsed notifiers — the only thing that changes on toggle.
  // GraphView itself is never rebuilt by setState.
  final Map<String, ValueNotifier<bool>> _collapsedNotifiers = {};
  bool _initialZoomDone = false;

  @override
  void initState() {
    super.initState();
    _setupGraph(widget.roadmap);
    // Fit the graph to the viewport after the first layout pass.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_initialZoomDone) {
        _controller.zoomToFit();
        _initialZoomDone = true;
      }
    });
  }

  @override
  void didUpdateWidget(covariant _RoadmapGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.roadmap, widget.roadmap)) {
      _initialZoomDone = false;
      _setupGraph(widget.roadmap);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_initialZoomDone) {
          _controller.zoomToFit();
          _initialZoomDone = true;
        }
      });
    }
  }

  @override
  void dispose() {
    for (final n in _collapsedNotifiers.values) {
      n.dispose();
    }
    super.dispose();
  }

  void _setupGraph(KnowledgeBaseRoadmapData roadmap) {
    for (final n in _collapsedNotifiers.values) {
      n.dispose();
    }
    _collapsedNotifiers.clear();

    _graph = Graph()..isTree = true;
    _controller = GraphViewController();
    _layoutConfig = BuchheimWalkerConfiguration()
      ..siblingSeparation = 44
      ..levelSeparation = 88
      ..subtreeSeparation = 52
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;

    _nodes = {for (final id in roadmap.nodes.keys) id: Node.Id(id)};

    for (final node in roadmap.nodes.values) {
      for (final childId in node.children) {
        final from = _nodes[node.id];
        final to = _nodes[childId];
        if (from != null && to != null) {
          _graph.addEdge(from, to);
        }
      }
    }

    final initiallyCollapsed = roadmap.initiallyCollapsedNodeIds.toSet();
    for (final id in roadmap.nodes.keys) {
      _collapsedNotifiers[id] = ValueNotifier<bool>(
        initiallyCollapsed.contains(id),
      );
    }

    final collapsedNodes = roadmap.initiallyCollapsedNodeIds
        .map((id) => _nodes[id])
        .whereType<Node>()
        .toList(growable: false);
    _controller.setInitiallyCollapsedNodes(_graph, collapsedNodes);
  }

  void _resetZoom() {
    _controller.zoomToFit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey600.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey400.withValues(alpha: 0.55)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: GraphView.builder(
                      graph: _graph,
                      controller: _controller,
                      algorithm: BuchheimWalkerAlgorithm(
                        _layoutConfig,
                        TreeEdgeRenderer(_layoutConfig),
                      ),
                      animated: true,
                      autoZoomToFit: false,
                      centerGraph: true,
                      panAnimationDuration: const Duration(milliseconds: 420),
                      toggleAnimationDuration: const Duration(
                        milliseconds: 320,
                      ),
                      builder: (node) {
                        final id = node.key?.value as String;
                        final nodeData = widget.roadmap.nodes[id];
                        if (nodeData == null) return const SizedBox.shrink();
                        final collapsedNotifier =
                            _collapsedNotifiers[id] ??
                            ValueNotifier<bool>(false);
                        return _RoadmapNodeCard(
                          data: nodeData,
                          accent: _parseHexColor(nodeData.accentHex),
                          collapsedNotifier: collapsedNotifier,
                          onOpenDescription: () {
                            widget.onSelectNodeInfo(nodeData);
                          },
                          onToggleExpand: () {
                            if (nodeData.children.isNotEmpty) {
                              _controller.toggleNodeExpanded(
                                _graph,
                                node,
                                animate: true,
                              );
                              // Only the notifier updates — no setState, no rebuild.
                              collapsedNotifier.value =
                                  !collapsedNotifier.value;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Tooltip(
                    message: 'Reset zoom',
                    child: Material(
                      color: AppColors.grey800.withValues(alpha: 0.88),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: _resetZoom,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.center_focus_strong_rounded,
                            color: AppColors.neon,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color _parseHexColor(String value) {
    final hex = value.replaceAll('#', '');
    final normalized = hex.length == 6 ? 'FF$hex' : hex;
    return Color(int.parse(normalized, radix: 16));
  }
}

class _RoadmapInfoPanel extends StatelessWidget {
  const _RoadmapInfoPanel({
    required this.fallbackNode,
    required this.selectedNodeListenable,
  });

  final KnowledgeBaseRoadmapNode fallbackNode;
  final ValueListenable<KnowledgeBaseRoadmapNode?> selectedNodeListenable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey600.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey400.withValues(alpha: 0.55)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ValueListenableBuilder<KnowledgeBaseRoadmapNode?>(
          valueListenable: selectedNodeListenable,
          builder: (context, selectedNode, _) {
            final node = selectedNode ?? fallbackNode;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                  child: Text(
                    node.title,
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Divider(color: AppColors.grey600, height: 1),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                    child: SingleChildScrollView(
                      child: Markdown(data: node.descriptionMarkdown),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RoadmapHeader extends StatelessWidget {
  const _RoadmapHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.grey600.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey400.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.neon.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.account_tree_rounded,
              color: AppColors.neon,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.knowledgeBaseNavRoadmap,
                  style: AppTextStyles.body1.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.knowledgeBaseRoadmapGraphHint,
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.grey200,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadmapNodeCard extends StatelessWidget {
  const _RoadmapNodeCard({
    required this.data,
    required this.accent,
    required this.collapsedNotifier,
    required this.onOpenDescription,
    required this.onToggleExpand,
  });

  final KnowledgeBaseRoadmapNode data;
  final Color accent;
  final ValueNotifier<bool> collapsedNotifier;
  final VoidCallback onOpenDescription;
  final VoidCallback onToggleExpand;

  double get _cardWidth {
    switch (data.kind) {
      case KnowledgeBaseRoadmapNodeKind.root:
        return 272;
      case KnowledgeBaseRoadmapNodeKind.milestone:
        return 252;
      case KnowledgeBaseRoadmapNodeKind.subtopic:
        return 224;
      case KnowledgeBaseRoadmapNodeKind.topic:
        return 182;
    }
  }

  double get _borderWidth {
    switch (data.kind) {
      case KnowledgeBaseRoadmapNodeKind.root:
        return 2.2;
      case KnowledgeBaseRoadmapNodeKind.milestone:
        return 2;
      case KnowledgeBaseRoadmapNodeKind.subtopic:
        return 1.4;
      case KnowledgeBaseRoadmapNodeKind.topic:
        return 1;
    }
  }

  IconData get _kindIcon {
    switch (data.kind) {
      case KnowledgeBaseRoadmapNodeKind.root:
        return Icons.hub_outlined;
      case KnowledgeBaseRoadmapNodeKind.milestone:
        return Icons.flag_outlined;
      case KnowledgeBaseRoadmapNodeKind.subtopic:
        return Icons.account_tree_outlined;
      case KnowledgeBaseRoadmapNodeKind.topic:
        return Icons.school_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasChildren = data.children.isNotEmpty;
    final glow = switch (data.kind) {
      KnowledgeBaseRoadmapNodeKind.root => 0.22,
      KnowledgeBaseRoadmapNodeKind.milestone => 0.2,
      KnowledgeBaseRoadmapNodeKind.subtopic => 0.16,
      KnowledgeBaseRoadmapNodeKind.topic => 0.12,
    };
    final titleStyle = switch (data.kind) {
      KnowledgeBaseRoadmapNodeKind.root => AppTextStyles.body1,
      KnowledgeBaseRoadmapNodeKind.milestone ||
      KnowledgeBaseRoadmapNodeKind.subtopic => AppTextStyles.body2,
      KnowledgeBaseRoadmapNodeKind.topic => AppTextStyles.caption1,
    };
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onOpenDescription,
        child: Ink(
          width: _cardWidth,
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.grey600.withValues(alpha: 0.96),
                AppColors.grey800,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              width: _borderWidth,
              color: accent.withValues(alpha: 0.72),
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: glow),
                blurRadius: data.kind == KnowledgeBaseRoadmapNodeKind.topic
                    ? 12
                    : 20,
                spreadRadius: 0.8,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_kindIcon, size: 18, color: accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      data.title,
                      maxLines: data.kind == KnowledgeBaseRoadmapNodeKind.topic
                          ? 2
                          : 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                data.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption1.copyWith(
                  color: AppColors.grey200,
                  height: 1.35,
                ),
              ),
              if (hasChildren) ...[
                const SizedBox(height: 8),
                ValueListenableBuilder<bool>(
                  valueListenable: collapsedNotifier,
                  builder: (context, collapsed, _) {
                    return Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: onToggleExpand,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            ),
                            child: Text(
                              collapsed ? 'Expand' : 'Collapse',
                              style: AppTextStyles.caption2.copyWith(
                                color: accent,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: onToggleExpand,
                          child: Icon(
                            collapsed
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.keyboard_arrow_up_rounded,
                            size: 18,
                            color: accent,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
