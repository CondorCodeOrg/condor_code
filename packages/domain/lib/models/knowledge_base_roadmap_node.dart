import 'package:domain/models/enums/knowledge_base_roadmap_node_kind.dart';

class KnowledgeBaseRoadmapNode {
  const KnowledgeBaseRoadmapNode({
    required this.id,
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.descriptionMarkdown,
    required this.accentHex,
    required this.children,
  });

  final String id;
  final KnowledgeBaseRoadmapNodeKind kind;
  final String title;
  final String subtitle;
  final String descriptionMarkdown;
  final String accentHex;
  final List<String> children;
}
