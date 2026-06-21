import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// Placeholder for structured articles, videos, and links.
class KnowledgeBaseResourcesScreen extends StatelessWidget {
  const KnowledgeBaseResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ColoredBox(
      color: context.colors.textPrimary,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            l10n.knowledgeBaseResourcesPlaceholder,
            style: AppTextStyles.body1.copyWith(color: context.colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
