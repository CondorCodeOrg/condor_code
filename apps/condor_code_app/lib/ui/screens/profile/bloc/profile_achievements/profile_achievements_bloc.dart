import 'package:condor_code/ui/screens/profile/providers/profile_screen_action_stream_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_achievements_event.dart';
part 'profile_achievements_state.dart';

// TODO refactor to common bloc.
class ProfileAchievementsBloc
    extends Bloc<ProfileAchievementsEvent, ProfileAchievementsState> {
  final ProfileScreenEventsProvider streamProvider;
  final ProfileRepository profileRepository;

  ProfileAchievementsBloc({
    required this.profileRepository,
    required this.streamProvider,
  }) : super(ProfileAchievementsLoading()) {
    on<ProfileAchievementsEvent>((event, emit) async {
      switch (event) {
        case OnLoadProfileAchievementsEvent():
          await _onGetAchievements(emit);
      }
    });
  }

  Future<void> _onGetAchievements(
    Emitter<ProfileAchievementsState> emit,
  ) async {
    await profileRepository.getAchievements().then((achievement) {
      emit(ProfileAchievementsLoaded(achievement: achievement));
    });
  }
}
