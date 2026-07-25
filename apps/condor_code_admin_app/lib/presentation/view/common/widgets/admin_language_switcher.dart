import 'package:condorcode_admin/presentation/logic/locale/locale_notifier.dart';
import 'package:condorcode_admin/utilities/context_extensions.dart';
import 'package:domain/models/enums/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

/// Compact language picker showing the current code (EN / UK).
class AdminLanguageSwitcher extends ConsumerWidget {
  const AdminLanguageSwitcher({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    final colors = context.colors;
    final strings = context.strings;

    return PopupMenuButton<AppLocale>(
      tooltip: strings.languageSwitcherTooltip,
      offset: const Offset(0, 40),
      color: colors.popupSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) =>
          ref.read(localeNotifierProvider.notifier).setLocale(value),
      itemBuilder: (context) => [
        PopupMenuItem<AppLocale>(
          value: AppLocale.en,
          child: _LanguageOption(
            label: strings.languageEnglish,
            code: AppLocale.en.displayCode,
            isSelected: locale == AppLocale.en,
          ),
        ),
        PopupMenuItem<AppLocale>(
          value: AppLocale.uk,
          child: _LanguageOption(
            label: strings.languageUkrainian,
            code: AppLocale.uk.displayCode,
            isSelected: locale == AppLocale.uk,
          ),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 12,
          vertical: compact ? 8 : 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              locale.displayCode,
              style: AppTextStyles.body2.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: colors.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.code,
    required this.isSelected,
  });

  final String label;
  final String code;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        SizedBox(
          width: 36,
          child: Text(
            code,
            style: AppTextStyles.body2.copyWith(
              color: isSelected ? colors.accent : colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.body2.copyWith(
              color: isSelected ? colors.textPrimary : colors.textSecondary,
            ),
          ),
        ),
        if (isSelected) Icon(Icons.check, color: colors.accent, size: 18),
      ],
    );
  }
}
