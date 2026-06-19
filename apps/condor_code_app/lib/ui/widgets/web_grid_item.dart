import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';
import 'package:ui_kit/ui_kit.dart';

class WebGridItem extends StatefulWidget {
  const WebGridItem({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.isLoading,
  });

  final VoidCallback onTap;
  final String imageUrl;
  final String name;
  final String description;
  final bool isLoading;

  @override
  State<WebGridItem> createState() => WebGridItemState();
}

class WebGridItemState extends State<WebGridItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    //TODO: Refactor to common images approach for both mobile and web.
    // final normalizedUrl = widget.imageUrl.trim();
    // final isSvg = normalizedUrl.toLowerCase().endsWith('.svg');

    return !widget.isLoading
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isHovered ? context.colors.accent : context.colors.border,
                    width: 0.8,
                  ),
                  color: isHovered ? context.colors.surface : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        //TODO: Refactor to common images approach for both mobile and web.
                        child: widget.name == 'Dart'
                            ? Image.asset(
                                'assets/images/dart_logo.png',
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                'assets/images/flutter_logo.png',
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body1.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      widget.description,
                      style: AppTextStyles.body2.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : _CustomSkeleton(widget: widget);
  }
}

class _CustomSkeleton extends StatelessWidget {
  const _CustomSkeleton({required this.widget});

  final WebGridItem widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.border, width: 0.8),
        color: Colors.transparent,
      ),
      child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: _ImagePlaceholder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                '              ',
                textAlign: TextAlign.center,
                style: AppTextStyles.body1.copyWith(color: context.colors.textPrimary),
              ),
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  '                               ',
                  style: AppTextStyles.body2.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
            ],
          ).redacted(
            context: context,
            redact: true,
            configuration: RedactedConfiguration(
              animationDuration: Duration(milliseconds: 1500),
              redactedColor: context.colors.textSecondary,
            ),
          ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.border.withValues(alpha: 0.2),
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined, size: 28, color: context.colors.textSecondary),
    );
  }
}
