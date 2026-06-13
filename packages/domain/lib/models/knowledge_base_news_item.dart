import 'package:domain/models/enums/knowledge_base_news_category.dart';

class KnowledgeBaseNewsItem {
  const KnowledgeBaseNewsItem({
    required this.id,
    required this.category,
    required this.relativeTimeLabel,
    required this.title,
    required this.snippet,
  });

  final String id;
  final KnowledgeBaseNewsCategory category;
  final String relativeTimeLabel;
  final String title;
  final String snippet;
}
