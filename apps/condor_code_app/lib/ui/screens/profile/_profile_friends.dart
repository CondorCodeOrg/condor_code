part of 'profile_screen.dart';

class _ProfileFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 22, bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.recommendedFriends, style: AppTextStyles.h1),
            Text(localization.viewAll, style: AppTextStyles.h1),
          ],
        ),
      ),
      // TODO: add this logic for mobile app.

      // SizedBox(
      //   height: 200,
      //   child: BlocBuilder<ProfileFriendsBloc, ProfileFriendsState>(
      //     builder: (context, state) {
      //       if (state is ProfileFriendLoaded) {
      //         return ListView.builder(
      //           scrollDirection: Axis.horizontal,
      //           itemBuilder: (BuildContext context, int index) =>
      //               FriendCardItem(friendData: state.friend[index]),
      //           itemCount: state.friend.length,
      //         );
      //       } else {
      //         return ListView.builder(
      //           scrollDirection: Axis.horizontal,
      //           itemBuilder: (BuildContext context, int index) =>
      //               const FriendCardSkeleton(),
      //           itemCount: 13,
      //         );
      //       }
      //     },
      //   ),
      // ),
    ],
  );
}

// class FriendCardSkeleton extends StatelessWidget {
//   const FriendCardSkeleton({super.key});
//
//   @override
//   Widget build(BuildContext context) =>
//       const Padding(padding: EdgeInsets.all(8), child: Skeleton(width: 136));
// }
