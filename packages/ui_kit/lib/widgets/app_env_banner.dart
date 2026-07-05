import 'package:flutter/material.dart';
import 'package:ui_kit/styles/colors/app_colors.dart';

enum AppEnvBannerStyle {
  light(backgroundColor: Colors.white, textColor: Colors.black),
  dark(backgroundColor: AppColors.darkGrey800, textColor: Colors.white);

  const AppEnvBannerStyle({
    required this.backgroundColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color textColor;
}

class AppEnvBanner extends StatelessWidget {
  final String environmentLabel;
  final AppEnvBannerStyle style;

  const AppEnvBanner({
    super.key,
    required this.environmentLabel,
    this.style = AppEnvBannerStyle.light,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Banner(
        message: environmentLabel,
        textDirection: TextDirection.ltr,
        location: BannerLocation.bottomEnd,
        color: style.backgroundColor,
        textStyle: TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w900,
          color: style.textColor,
        ),
      ),
    );
  }
}
