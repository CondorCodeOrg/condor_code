import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:condorcode_admin/presentation/logic/users/tester_requests_notifier/tester_requests_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/legacy.dart';

//TODO: Rewrite this using BLoC pattern according to the project's architecture guidelines.
final testerRequestsProvider =
    StateNotifierProvider.autoDispose<
      TesterRequestsNotifier,
      TesterRequestsState
    >(
      (ref) => TesterRequestsNotifier(
        testerAccessRepository: ref.watch(testerAccessRepositoryProvider),
      ),
    );

class TesterRequestsNotifier extends StateNotifier<TesterRequestsState> {
  TesterRequestsNotifier({required this.testerAccessRepository})
    : super(const TesterRequestsState());

  final TesterAccessRepository testerAccessRepository;

  Future<void> loadRequests() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await testerAccessRepository.fetchPendingRequests();

    result.fold(
      onSuccess: (requests) {
        state = state.copyWith(isLoading: false, requests: requests);
      },
      onError: (error) {
        state = state.copyWith(isLoading: false, errorMessage: error.message);
      },
    );
  }

  Future<void> approve(TesterAccessRequest request) async {
    state = state.copyWith(isProcessing: true, errorMessage: null);

    final result = await testerAccessRepository.approveRequest(
      requestId: request.id,
      userId: request.userId,
    );

    result.fold(
      onSuccess: (_) async {
        state = state.copyWith(isProcessing: false);
        await loadRequests();
      },
      onError: (error) {
        state = state.copyWith(
          isProcessing: false,
          errorMessage: error.message,
        );
      },
    );
  }

  Future<void> reject(TesterAccessRequest request) async {
    state = state.copyWith(isProcessing: true, errorMessage: null);

    final result = await testerAccessRepository.rejectRequest(
      requestId: request.id,
    );

    result.fold(
      onSuccess: (_) async {
        state = state.copyWith(isProcessing: false);
        await loadRequests();
      },
      onError: (error) {
        state = state.copyWith(
          isProcessing: false,
          errorMessage: error.message,
        );
      },
    );
  }
}
