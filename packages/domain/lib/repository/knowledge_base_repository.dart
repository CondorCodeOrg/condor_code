import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/knowledge_base_news_item.dart';
import 'package:domain/models/knowledge_base_roadmap_data.dart';

abstract class KnowledgeBaseRepository {
  Future<DataResult<List<KnowledgeBaseNewsItem>>> fetchLatestNews();

  Future<DataResult<KnowledgeBaseRoadmapData>> fetchRoadmap();
}
