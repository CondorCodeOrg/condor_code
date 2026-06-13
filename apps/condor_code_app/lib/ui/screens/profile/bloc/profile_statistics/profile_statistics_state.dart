part of 'profile_statistics_bloc.dart';

sealed class ProfileStatisticsState {}

final class ProfileStatisticsLoading extends ProfileStatisticsState {}

final class ProfileStatisticsLoaded extends ProfileStatisticsState {
  final List<Statistic> statisticCard;

  ProfileStatisticsLoaded({required this.statisticCard});
}
