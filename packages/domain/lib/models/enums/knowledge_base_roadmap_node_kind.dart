/// Role of a node in the knowledge-base roadmap graph.
enum KnowledgeBaseRoadmapNodeKind {
  /// Top summary (roadmap title).
  root,

  /// Major learning phase; connects the main journey steps.
  milestone,

  /// Group under a milestone (chapter / module).
  subtopic,

  /// Concrete lesson or skill leaf (or container for further nesting).
  topic,
}
