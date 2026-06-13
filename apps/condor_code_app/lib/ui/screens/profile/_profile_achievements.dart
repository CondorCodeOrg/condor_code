part of 'profile_screen.dart';

class _ProfileAchievements extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.achievements, style: AppTextStyles.h1),
            Text(localization.viewAll, style: AppTextStyles.h1),
          ],
        ),
      ),
      // TODO: add this logic for mobile app.

      // SizedBox(
      //   height: 136,
      //   child: BlocBuilder<ProfileAchievementsBloc, ProfileAchievementsState>(
      //     builder: (context, state) {
      //       if (state is ProfileAchievementsLoaded) {
      //         return GridView.builder(
      //           physics: const NeverScrollableScrollPhysics(),
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 3,
      //           ),
      //           itemCount: 3,
      //           itemBuilder: (context, index) => AchievementCardItem(
      //             achievementData: state.achievement[index],
      //           ),
      //         );
      //       } else {
      //         return GridView.builder(
      //           physics: const NeverScrollableScrollPhysics(),
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 3,
      //           ),
      //           itemCount: 3,
      //           itemBuilder: (context, index) =>
      //               const AchievementCardSkeleton(),
      //         );
      //       }
      //     },
      //   ),
      // ),
    ],
  );
}

// TODO: add this logic for mobile app.

// class AchievementCardSkeleton extends StatelessWidget {
//   const AchievementCardSkeleton({super.key});
//
//   @override
//   Widget build(BuildContext context) =>
//       const Skeleton(height: double.infinity, width: double.infinity);
// }
