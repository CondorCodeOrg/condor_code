import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    required this.label,
    this.iconSize = 60,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.letterSpacing = 0.8,
    this.onTap,
  });

  static const String _appIconAsset = 'assets/images/condor_app_icon.png';

  final double iconSize;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final AppLogoLabel label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            _appIconAsset,
            package: 'ui_kit',
            width: iconSize,
            height: iconSize,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
            ),
            children: const [
              TextSpan(
                text: 'CONDOR_',
                style: TextStyle(color: AppColors.white),
              ),
              TextSpan(
                text: 'CODE',
                style: TextStyle(color: AppColors.neon),
              ),
            ],
          ),
        ),
        label == AppLogoLabel.prod
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  label == AppLogoLabel.dev ? 'DEV' : 'STAGE',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neon,
                  ),
                ),
              ),
      ],
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: content,
        ),
      ),
    );
  }
}

enum AppLogoLabel { prod, dev, staging }
