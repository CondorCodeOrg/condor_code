import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/side_panel_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class KnowledgeCheckActionPanel extends StatelessWidget {
  const KnowledgeCheckActionPanel({super.key, this.expanded = false});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    if (!expanded) {
      return _CheckAnswerButton();
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.border.withValues(alpha: 0.55)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SidePanelHeader(
              icon: Icons.bolt_rounded,
              title: localization.knowledgeCheckActions,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _CheckAnswerButton(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _CheckAnswerButton extends StatelessWidget {
  const _CheckAnswerButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        // TODO write an implementation if needed in the future
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.accent,
          foregroundColor: context.colors.textPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.check_circle_outline, size: 20),
        label: Text(
          localization.checkAnswer,
          style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
