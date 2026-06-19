import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/app_theme_toggle_button.dart';
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
      backgroundColor: context.colors.scaffoldBackground,
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
            const Spacer(),
            const Align(
              alignment: Alignment.centerRight,
              child: AppThemeToggleButton(),
            ),
            const SizedBox(height: 16),
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
