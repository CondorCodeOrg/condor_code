import 'package:condor_code/ui/screens/profile/providers/profile_screen_action_stream_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_statistics_event.dart';
part 'profile_statistics_state.dart';

class ProfileStatisticsBloc
    extends Bloc<ProfileStatisticsEvent, ProfileStatisticsState> {
  final ProfileScreenEventsProvider streamProvider;
  final ProfileRepository profileRepository;

  ProfileStatisticsBloc(this.streamProvider, this.profileRepository)
    : super(ProfileStatisticsLoading()) {
    on<ProfileStatisticsEvent>((event, emit) async {
      switch (event) {
        case OnLoadProfileStatisticsEvent():
          await _onGetStatistic(emit);
      }
    });
  }

  Future<void> _onGetStatistic(Emitter<ProfileStatisticsState> emit) async {
    await profileRepository.getStatistic().then((statisticCard) {
      emit(ProfileStatisticsLoaded(statisticCard: statisticCard));
    });
  }
}
