import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/condor_code_network_image_view.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.navigation,
    this.bottomText,
  });

  /// Resolved display string (typically from domain getters like [Course.name], [LessonItem.name]).
  final String name;
  final String imageUrl, id;
  final String? bottomText;
  final VoidCallback navigation;

  @override
  Widget build(BuildContext context) {
    final normalizedUrl = imageUrl.trim();
    final isSvg = normalizedUrl.toLowerCase().endsWith('.svg');

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: navigation,
        child: Container(
          width: double.infinity,
          height: 68,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey400, width: 0.6),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: normalizedUrl.isEmpty
                      ? _ImagePlaceholder()
                      : isSvg
                      ? SvgPicture.network(
                          normalizedUrl,
                          placeholderBuilder: (_) => _ImagePlaceholder(),
                        )
                      : CCNetworkImageView(
                          imageUrl: normalizedUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _ImagePlaceholder(),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        if (bottomText != null)
                          Text(
                            bottomText!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.lightGrey,
                            ),
                          ),
                      ],
                    ),
                    SvgPicture.asset(
                      AppIcons.arrowRight,
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey400.withValues(alpha: 0.2),
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined, size: 18, color: Colors.grey.shade500),
    );
  }
}
