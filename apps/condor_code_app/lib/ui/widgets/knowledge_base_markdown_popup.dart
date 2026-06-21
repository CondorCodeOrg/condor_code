import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/markdown.dart';

Future<void> showKnowledgeBaseMarkdownPopup(
  BuildContext context, {
  required String title,
  required String markdown,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) =>
        KnowledgeBaseMarkdownPopup(title: title, markdown: markdown),
  );
}

class KnowledgeBaseMarkdownPopup extends StatelessWidget {
  const KnowledgeBaseMarkdownPopup({
    super.key,
    required this.title,
    required this.markdown,
  });

  final String title;
  final String markdown;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final maxWidth = width > 920 ? 760.0 : width - 32;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: 680),
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.scaffoldBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.border.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 14, 10, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.body1.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close_rounded),
                      color: context.colors.textSecondary,
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ),
              Divider(color: context.colors.surface, height: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Markdown(data: markdown),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
