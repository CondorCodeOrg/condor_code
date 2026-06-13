import 'package:domain/domain.dart';

class KnowledgeBaseRoadmapState {
  const KnowledgeBaseRoadmapState({this.roadmap, this.isLoading = false});

  final KnowledgeBaseRoadmapData? roadmap;
  final bool isLoading;

  KnowledgeBaseRoadmapState copyWith({
    KnowledgeBaseRoadmapData? roadmap,
    bool? isLoading,
  }) {
    return KnowledgeBaseRoadmapState(
      roadmap: roadmap ?? this.roadmap,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
