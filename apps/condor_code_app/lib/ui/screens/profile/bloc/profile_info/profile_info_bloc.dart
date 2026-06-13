import 'package:condor_code/ui/screens/profile/providers/profile_screen_action_stream_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

// TODO refactor to common bloc.
class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final ProfileScreenEventsProvider streamProvider;
  final ProfileRepository profileRepository;

  ProfileInfoBloc({
    required this.streamProvider,
    required this.profileRepository,
  }) : super(ProfileInfoLoading()) {
    on<ProfileInfoEvent>((event, emit) async {
      switch (event) {
        case OnLoadProfileInfoEvent():
          await _onGetInfo(emit);
      }
    });
  }

  Future<void> _onGetInfo(Emitter<ProfileInfoState> emit) async {
    await profileRepository.getUser().then((user) {
      emit(ProfileInfoLoaded(user: user));
    });
  }
}
