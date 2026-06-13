import 'package:condor_code/ui/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:condor_code/di/provider_manager.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/screens/profile_setting_screen.dart';
import 'package:condor_code/ui/screens/profile/bloc/profile_achievements/profile_achievements_bloc.dart';
import 'package:condor_code/ui/screens/profile/bloc/profile_friends/profile_friends_bloc.dart';
import 'package:condor_code/ui/screens/profile/bloc/profile_info/profile_info_bloc.dart';
import 'package:condor_code/ui/screens/profile/bloc/profile_statistics/profile_statistics_bloc.dart';

part '_profile_achievements.dart';
part '_profile_friends.dart';
part '_profile_header.dart';
part '_profile_statistics.dart';

// TODO: Refactor this screen with skeletons and right design. Add error handling and loading states.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            di<ProfileInfoBloc>()..add(OnLoadProfileInfoEvent()),
      ),
      BlocProvider(
        create: (context) =>
            di<ProfileStatisticsBloc>()..add(OnLoadProfileStatisticsEvent()),
      ),
      BlocProvider(
        create: (context) =>
            di<ProfileFriendsBloc>()..add(OnLoadProfileFriendsEvent()),
      ),
      BlocProvider(
        create: (context) =>
            di<ProfileAchievementsBloc>()
              ..add(OnLoadProfileAchievementsEvent()),
      ),
    ],
    child: Scaffold(
      backgroundColor: AppColors.grey800,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileHeader(),
                _ProfileStatistic(),
                _ProfileAchievements(),
                _ProfileFriends(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
