import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.description,
  });

  final String imgUrl, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        Image.asset(
          imgUrl,
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 3,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            title,
            style: kIsWeb
                ? AppTextStyles.h1.copyWith(
                    color: context.colors.textSecondary,
                    fontSize: 24,
                  )
                : AppTextStyles.h2.copyWith(color: context.colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          description,
          style: kIsWeb
              ? AppTextStyles.h2.copyWith(
                  color: context.colors.textSecondary,
                  fontSize: 20,
                )
              : AppTextStyles.inputHint,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        kIsWeb
            ? SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 12,
                child: ElevatedButton(
                  style: AppButtonStyles.mainButtonStyle(context).copyWith(),
                  onPressed: () => _onButtonPressed(context),
                  child: Text(localization.letUsKnow),
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppButtonStyles.mainButtonStyle(context).copyWith(),
                  onPressed: () => _onButtonPressed(context),
                  child: Text(localization.letUsKnow),
                ),
              ),
      ],
    );
  }

  void _onButtonPressed(BuildContext context) {
    di<Analytics>().logEvent(AnalyticsEventName.wishFlutterCourse, {});
    context.go(RouteConstants.contactsScreen);
  }
}
