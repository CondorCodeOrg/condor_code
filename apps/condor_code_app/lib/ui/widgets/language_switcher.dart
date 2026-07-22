import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/screens/locale/locale_cubit/locale_cubit.dart';
import 'package:domain/models/enums/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

/// Compact language picker showing the current code (EN / UK).
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key, this.compact = false});

  /// When true, uses tighter padding for overlay placement (e.g. mobile).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, AppLocale>(
      builder: (context, locale) {
        final l10n = AppLocalizations.of(context)!;
        final colors = context.colors;

        return PopupMenuButton<AppLocale>(
          tooltip: l10n.languageSwitcherTooltip,
          offset: const Offset(0, 40),
          color: colors.popupSurface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) => context.read<LocaleCubit>().setLocale(value),
          itemBuilder: (context) => [
            PopupMenuItem<AppLocale>(
              value: AppLocale.en,
              child: _LanguageOption(
                label: l10n.languageEnglish,
                code: AppLocale.en.displayCode,
                isSelected: locale == AppLocale.en,
              ),
            ),
            PopupMenuItem<AppLocale>(
              value: AppLocale.uk,
              child: _LanguageOption(
                label: l10n.languageUkrainian,
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
      },
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
