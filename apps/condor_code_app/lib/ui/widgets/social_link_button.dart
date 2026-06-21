import 'package:ui_kit/ui_kit.dart';
import 'package:domain/models/social_link.dart';
import 'package:flutter/material.dart';

class SocialLinkButton extends StatelessWidget {
  final SocialLink link;

  SocialLinkButton({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.scaffoldBackground,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.border, width: 0.8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: open link via launchUrl. link.url
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(link.icon, color: context.colors.textPrimary, size: 28),
                SizedBox(width: 12),
                Text(
                  link.name,
                  style: AppTextStyles.h1.copyWith(color: context.colors.textPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
