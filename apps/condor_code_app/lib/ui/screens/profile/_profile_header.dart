part of 'profile_screen.dart';

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
    builder: (context, state) {
      if (state is ProfileInfoLoaded) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Image.asset(
                    'assets/images/duolingo.webp',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.settings, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileSettingScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            //TODO: return to this code when the API will be ready
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       style: AppTextStyles.h1,
            //       '${state.user.name} ${state.user.lastName}',
            //     ),
            //     SvgPicture.asset(
            //       'assets/images/united-states.svg',
            //       height: 30,
            //       width: 30,
            //     ),
            //   ],
            // ),
            // Text(
            //   state.user.nickname.toString(),
            //   textAlign: TextAlign.start,
            //   style: AppTextStyles.body1,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 12),
            //   child: Text(
            //     '${localization.registration}: ${state.user.registrationDate}',
            //     textAlign: TextAlign.start,
            //     style: AppTextStyles.body1,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 16),
            //   child: Text(
            //     '${state.user.subscriptionsCount} ${localization.subscriptions}    ${state.user.subscribersCount} ${localization.subscribers}',
            //     textAlign: TextAlign.start,
            //     style: AppTextStyles.body1,
            //   ),
            // ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: AppButtonStyles.mainButtonStyle,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_add_alt_1, color: Colors.blue),
                        const SizedBox(width: 12),
                        Text(
                          localization.addFriends,
                          style: AppTextStyles.body1,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ElevatedButton(
                    style: AppButtonStyles.mainButtonStyle,
                    onPressed: () {},
                    child: const Icon(Icons.download, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Container(
                height: 1,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ),
          ],
        );
      } else {
        return const HeaderSkelton();
      }
    },
  );
}

class HeaderSkelton extends StatelessWidget {
  const HeaderSkelton({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // TODO: add this logic for mobile app.

      // // Center(
      // //   child: Stack(
      // //     children: [
      // //       Padding(
      // //         padding: EdgeInsets.only(bottom: 16),
      // //         child: Skeleton(height: 200, width: double.infinity),
      // //       ),
      // //       Positioned(
      // //         right: 0,
      // //         top: 0,
      // //         child: Skeleton(height: 30, width: 30),
      // //       ),
      // //     ],
      // //   ),
      // // ),
      // // Row(
      // //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // //   children: [
      // //     Skeleton(height: 10, width: 100),
      // //     Skeleton(height: 30, width: 30),
      // //   ],
      // // ),
      // // Skeleton(height: 10, width: 40),
      // // Padding(
      // //   padding: EdgeInsets.only(bottom: 12, top: 10),
      // //   child: Skeleton(height: 10, width: 200),
      // // ),
      // // Padding(
      // //   padding: EdgeInsets.only(bottom: 16),
      // //   child: Skeleton(height: 10, width: 100),
      // // ),
      // // Row(
      // //   children: [
      // //     Expanded(child: Skeleton(height: 54, width: double.infinity)),
      // //     Padding(
      // //       padding: EdgeInsets.only(left: 16),
      // //       child: Skeleton(height: 54, width: 54),
      // //     ),
      //   ],
      // ),
    ],
  );
}
