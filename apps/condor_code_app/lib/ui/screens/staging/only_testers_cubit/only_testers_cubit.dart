import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:condor_code/ui/screens/staging/only_testers_cubit/only_testers_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:domain/domain.dart';

class OnlyTestersCubit extends BaseCubit<OnlyTestersState> {
  OnlyTestersCubit({
    required TesterAccessRepository testerAccessRepository,
    required super.snackBarEventsProvider,
  }) : _testerAccessRepository = testerAccessRepository,
       super(const OnlyTestersState()) {
    loadMyRequest();
  }

  final TesterAccessRepository _testerAccessRepository;

  Future<void> loadMyRequest() async {
    emit(state.copyWith(isLoading: true));
    await processDataResult(
      _testerAccessRepository.fetchMyRequest(),
      onSuccess: (request) => emit(state.copyWith(myRequest: request)),
    );
    emit(state.copyWith(isLoading: false));
  }

  Future<void> requestTesterAccess() async {
    if (state.hasPendingRequest) {
      showErrorSnackBar(localization.onlyTestersRequestAlreadyPending);
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    await processDataResult(
      _testerAccessRepository.submitAccessRequest(),
      onSuccess: (_) {
        snackBarEventsProvider.addEvent(
          SnackBarEvent.success(localization.onlyTestersRequestSent),
        );
        loadMyRequest();
      },
      onError: (e) {
        if (e.message.toLowerCase().contains('request-already-pending')) {
          showErrorSnackBar(localization.onlyTestersRequestAlreadyPending);
          loadMyRequest();
          return;
        }
        showErrorSnackBar(e.message);
      },
    );
    emit(state.copyWith(isSubmitting: false));
  }
}
