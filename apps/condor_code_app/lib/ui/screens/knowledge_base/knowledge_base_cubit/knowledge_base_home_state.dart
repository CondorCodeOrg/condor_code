import 'package:domain/domain.dart';

class KnowledgeBaseHomeState {
  const KnowledgeBaseHomeState({this.news = const [], this.isLoading = false});

  final List<KnowledgeBaseNewsItem> news;
  final bool isLoading;

  KnowledgeBaseHomeState copyWith({
    List<KnowledgeBaseNewsItem>? news,
    bool? isLoading,
  }) {
    return KnowledgeBaseHomeState(
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
