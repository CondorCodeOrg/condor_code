part of 'profile_info_bloc.dart';

sealed class ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}

final class ProfileInfoLoaded extends ProfileInfoState {
  final User user;

  ProfileInfoLoaded({required this.user});
}
