part of 'profile_screen.dart';

class _ProfileStatistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 22, bottom: 18),
        child: Text(localization.statistics, style: AppTextStyles.h1),
      ),
      // TODO: add this logic for mobile app.

      // SizedBox(
      //   height: 160,
      //   child: BlocBuilder<ProfileStatisticsBloc, ProfileStatisticsState>(
      //     builder: (context, state) {
      //       if (state is ProfileStatisticsLoaded) {
      //         return GridView.builder(
      //           physics: const NeverScrollableScrollPhysics(),
      //           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //             maxCrossAxisExtent: 200,
      //             childAspectRatio: 5 / 2,
      //           ),
      //           itemCount: state.statisticCard.length,
      //           itemBuilder: (context, index) => StatisticCardItem(
      //             statisticData: state.statisticCard[index],
      //           ),
      //         );
      //       } else {
      //         return const SizedBox.shrink();
      //       }
      //     },
      //   ),
      // ),
    ],
  );
}

//
// class StatisticCardSkeleton extends StatelessWidget {
//   const StatisticCardSkeleton({super.key});
//
//   @override
//   Widget build(BuildContext context) => const Padding(
//     padding: EdgeInsets.all(8),
//     child: Skeleton(height: 100, width: 160),
//   );
// }
