import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:condor_code/ui/screens/knowledge_base/knowledge_base_cubit/knowledge_base_home_state.dart';
import 'package:domain/domain.dart';

class KnowledgeBaseHomeCubit extends BaseCubit<KnowledgeBaseHomeState> {
  KnowledgeBaseHomeCubit({
    required this.knowledgeBaseRepository,
    required super.snackBarEventsProvider,
  }) : super(const KnowledgeBaseHomeState()) {
    loadNews();
  }

  final KnowledgeBaseRepository knowledgeBaseRepository;

  Future<void> loadNews() async {
    emit(state.copyWith(isLoading: true));
    final result = await knowledgeBaseRepository.fetchLatestNews();
    result.fold(
      onSuccess: (news) {
        emit(state.copyWith(news: news, isLoading: false));
      },
      onError: (error) {
        emit(state.copyWith(isLoading: false));
        snackBarEventsProvider.addEvent(SnackBarEvent.error(error.message));
      },
    );
  }
}
