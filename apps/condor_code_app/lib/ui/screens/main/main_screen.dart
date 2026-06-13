import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/screens/staging/staging_auth_cubit/staging_auth_cubit.dart';
import 'package:condor_code/ui/screens/staging/staging_auth_cubit/staging_auth_state.dart';
import 'package:condor_code/ui/widgets/app_drawer.dart';
import 'package:condor_code/ui/widgets/nav_button.dart';
import 'package:condor_code/ui/widgets/snack_bar/snack_bar_producer_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(this.navigationShell, {super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  static const double _desktopBreakpoint = 1024;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= MainScreen._desktopBreakpoint;
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.path;
    final isKnowledgeCheck = location.startsWith(
      '${RouteConstants.knowledgeCheck}/',
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.grey800,
      drawer: isDesktop ? null : const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('packages/ui_kit/assets/images/bg & pattern.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            if (isDesktop)
              BlocProvider.value(
                value: di<StagingAuthCubit>(),
                child: const SafeArea(child: _TopNavigationBar()),
              ),
            Expanded(
              child: Stack(
                children: [
                  SnackBarProducerWidget(child: widget.navigationShell),
                  if (!isDesktop && !isKnowledgeCheck)
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(left: 18, top: 12),
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: AppColors.white,
                              ),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopNavigationBar extends StatelessWidget {
  const _TopNavigationBar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 60),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => context.go(RouteConstants.home),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: AppLogo(label: _getLogoLabel()),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NavButton(
                  title: l10n.home,
                  onTap: () {
                    di<Analytics>().logEvent(AnalyticsEventName.navClick, {
                      AnalyticsPropertyName.destination: RouteConstants.home,
                    });
                    context.go(RouteConstants.home);
                  },
                  route: RouteConstants.home,
                ),
                NavButton(
                  title: l10n.courses,
                  onTap: () {
                    di<Analytics>().logEvent(AnalyticsEventName.navClick, {
                      AnalyticsPropertyName.destination: RouteConstants.courses,
                    });
                    context.go(RouteConstants.courses);
                  },
                  route: RouteConstants.courses,
                ),
                // TODO: uncomment when knowledge base is ready
                // NavButton(
                //   title: l10n.knowledgeBase,
                //   onTap: () => context.go(RouteConstants.knowledgeBase),
                //   route: RouteConstants.knowledgeBase,
                // ),
                NavButton(
                  title: l10n.contactsScreen,
                  onTap: () {
                    di<Analytics>().logEvent(AnalyticsEventName.navClick, {
                      AnalyticsPropertyName.destination:
                          RouteConstants.contactsScreen,
                    });
                    context.go(RouteConstants.contactsScreen);
                  },
                  route: RouteConstants.contactsScreen,
                ),
              ],
            ),
          ),
          if (di<AppConfig>().isStaging)
            BlocBuilder<StagingAuthCubit, StagingAuthState>(
              builder: (context, state) {
                final user = state.user;
                if (user == null) return const SizedBox.shrink();
                return _ProfilePopupMenu(user: user);
              },
            )
          else
            SizedBox(width: MediaQuery.of(context).size.width * 0.136),
        ],
      ),
    );
  }

  AppLogoLabel _getLogoLabel() => switch (di<AppConfig>().buildType) {
    BuildType.dev => AppLogoLabel.dev,
    BuildType.staging => AppLogoLabel.staging,
    BuildType.prod => AppLogoLabel.prod,
  };
}

class _ProfilePopupMenu extends StatelessWidget {
  final User user;

  const _ProfilePopupMenu({required this.user});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopupMenuButton<VoidCallback>(
      tooltip: l10n.stagingProfileTitle,
      offset: const Offset(0, 40),
      color: AppColors.grey600,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Icon(Icons.person_outline, color: AppColors.white),
      ),
      itemBuilder: (context) => [
        PopupMenuItem<VoidCallback>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.email,
                style: AppTextStyles.body2.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 2),
              _RoleLabelText(role: user.role),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<VoidCallback>(
          value: () async {
            final cubit = context.read<StagingAuthCubit>();
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (_) => _LogoutConfirmationDialog(l10n: l10n),
            );
            if (confirmed == true) {
              await cubit.logout();
            }
          },
          child: Text(
            l10n.stagingProfileSignOut,
            style: AppTextStyles.body2.copyWith(color: AppColors.neon),
          ),
        ),
      ],
      onSelected: (callback) => callback(),
    );
  }
}

class _LogoutConfirmationDialog extends StatelessWidget {
  final AppLocalizations l10n;

  const _LogoutConfirmationDialog({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.grey600,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        l10n.stagingProfileSignOutConfirmTitle,
        style: AppTextStyles.h2.copyWith(color: AppColors.white),
      ),
      content: Text(
        l10n.stagingProfileSignOutConfirm,
        style: AppTextStyles.body1.copyWith(color: AppColors.grey200),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            l10n.stagingProfileCancel,
            style: AppTextStyles.body2.copyWith(color: AppColors.grey200),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            l10n.stagingProfileSignOut,
            style: AppTextStyles.body2.copyWith(color: AppColors.neon),
          ),
        ),
      ],
    );
  }
}

class _RoleLabelText extends StatelessWidget {
  final UserRole role;

  const _RoleLabelText({required this.role});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Text(switch (role) {
      UserRole.admin => l10n.stagingRoleAdmin,
      UserRole.tester => l10n.stagingRoleTester,
      UserRole.user => l10n.stagingRoleUser,
      UserRole.developer => l10n.stagingRoleDeveloper,
      UserRole.patron => l10n.stagingRolePatron,
      UserRole.patronDeveloper => l10n.stagingRolePatronDeveloper,
    }, style: AppTextStyles.caption1.copyWith(color: AppColors.grey200));
  }
}

// return Scaffold(
//   body: SnackBarProducerWidget(child: navigationShell),
//   backgroundColor: AppColors.grey800,
//   bottomNavigationBar: NavigationBarTheme(
//     data: NavigationBarThemeData(
//       height: 80,
//       labelTextStyle: WidgetStateProperty.all(AppTextStyles.body3),
//       indicatorColor: AppColors.neon,
//     ),
//     child: BottomNavigationBar(
//       selectedItemColor: AppColors.white,
//       unselectedItemColor: AppColors.grey200,
//       selectedLabelStyle: AppTextStyles.body2.copyWith(
//         color: AppColors.white,
//       ),
//       unselectedLabelStyle: AppTextStyles.body2.copyWith(
//         color: AppColors.grey200,
//       ),
//       currentIndex: navigationShell.currentIndex,
//       backgroundColor: AppColors.grey800,
//       items: [
//         BottomNavigationBarItem(
//           icon: navigationShell.currentIndex == _MainTabs.courses.index
//               ? SvgPicture.asset(AppIcons.coursesChosen)
//               : SvgPicture.asset(AppIcons.courses),
//           label: localization.courses,
//         ),
//         BottomNavigationBarItem(
//           icon: navigationShell.currentIndex == _MainTabs.profile.index
//               ? SvgPicture.asset(
//                   AppIcons.profile,
//                   colorFilter: const ColorFilter.mode(
//                     AppColors.white,
//                     BlendMode.srcIn,
//                   ),
//                 )
//               : SvgPicture.asset(AppIcons.profile),
//           label: localization.profile,
//         ),
//       ],
//       onTap: _onItemTap,
//     ),
//   ),
// );
//   }
// }
