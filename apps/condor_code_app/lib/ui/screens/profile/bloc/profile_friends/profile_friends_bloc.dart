import 'package:condor_code/ui/screens/profile/providers/profile_screen_action_stream_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_friends_event.dart';
part 'profile_friends_state.dart';

class ProfileFriendsBloc
    extends Bloc<ProfileFriendsEvent, ProfileFriendsState> {
  final ProfileScreenEventsProvider streamProvider;
  final ProfileRepository profileRepository;

  ProfileFriendsBloc(this.streamProvider, this.profileRepository)
    : super(ProfileFriendsLoading()) {
    on<ProfileFriendsEvent>((event, emit) async {
      switch (event) {
        case OnLoadProfileFriendsEvent():
          await _onGetFriends(emit);
      }
    });
  }

  Future<void> _onGetFriends(Emitter<ProfileFriendsState> emit) async {
    await profileRepository.getFriends().then((friend) {
      emit(ProfileFriendLoaded(friend: friend));
    });
  }
}
