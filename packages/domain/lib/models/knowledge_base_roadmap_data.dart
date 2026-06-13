import 'package:domain/models/knowledge_base_roadmap_node.dart';

class KnowledgeBaseRoadmapData {
  const KnowledgeBaseRoadmapData({
    required this.rootId,
    required this.nodes,
    required this.initiallyCollapsedNodeIds,
  });

  final String rootId;
  final Map<String, KnowledgeBaseRoadmapNode> nodes;
  final List<String> initiallyCollapsedNodeIds;
}
