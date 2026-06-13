import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:condor_code/ui/screens/knowledge_base/roadmap/cubit/knowledge_base_roadmap_state.dart';
import 'package:domain/domain.dart';

class KnowledgeBaseRoadmapCubit extends BaseCubit<KnowledgeBaseRoadmapState> {
  KnowledgeBaseRoadmapCubit({
    required this.knowledgeBaseRepository,
    required super.snackBarEventsProvider,
  }) : super(const KnowledgeBaseRoadmapState()) {
    loadRoadmap();
  }

  final KnowledgeBaseRepository knowledgeBaseRepository;

  Future<void> loadRoadmap() async {
    emit(state.copyWith(isLoading: true));
    final result = await knowledgeBaseRepository.fetchRoadmap();
    result.fold(
      onSuccess: (roadmap) {
        emit(state.copyWith(roadmap: roadmap, isLoading: false));
      },
      onError: (error) {
        emit(state.copyWith(isLoading: false));
        snackBarEventsProvider.addEvent(SnackBarEvent.error(error.message));
      },
    );
  }
}
