part of 'profile_friends_bloc.dart';

sealed class ProfileFriendsState {}

final class ProfileFriendsLoading extends ProfileFriendsState {}

final class ProfileFriendLoaded extends ProfileFriendsState {
  final List<Friend> friend;

  ProfileFriendLoaded({required this.friend});
}
