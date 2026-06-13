part of 'profile_achievements_bloc.dart';

sealed class ProfileAchievementsState {}

final class ProfileAchievementsLoading extends ProfileAchievementsState {}

final class ProfileAchievementsLoaded extends ProfileAchievementsState {
  final List<Achievement> achievement;

  ProfileAchievementsLoaded({required this.achievement});
}
