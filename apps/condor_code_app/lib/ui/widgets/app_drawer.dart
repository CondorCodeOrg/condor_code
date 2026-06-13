import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/drawer_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.grey800,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppLogo(
                iconSize: 34,
                fontSize: 17,
                onTap: kIsWeb
                    ? () {
                        // TODO rename to home
                        context.go(RouteConstants.home);
                        Navigator.pop(context);
                      }
                    : null,
                label: _getLogoLabel(),
              ),
            ),
            const SizedBox(height: 10),
            if (kIsWeb)
              DrawerItem(
                title: localization.home,
                onTap: () {
                  context.go(RouteConstants.home);
                  Navigator.pop(context);
                },
              ),
            DrawerItem(
              title: localization.contactsScreen,
              onTap: () {
                context.go(RouteConstants.contactsScreen);
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              title: localization.courses,
              onTap: () {
                context.go(RouteConstants.courses);
                Navigator.pop(context);
              },
            ),
            // TODO: uncomment when knowledge base is ready
            // DrawerItem(
            //   title: localization.knowledgeBase,
            //   onTap: () {
            //     context.go(RouteConstants.knowledgeBase);
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  AppLogoLabel _getLogoLabel() => switch (di<AppConfig>().buildType) {
    BuildType.dev => AppLogoLabel.dev,
    BuildType.staging => AppLogoLabel.staging,
    BuildType.prod => AppLogoLabel.prod,
  };
}
