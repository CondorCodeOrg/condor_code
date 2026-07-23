enum AppLocale {
  en,
  uk;

  String get languageCode => name;

  /// Display code for the language switcher button (EN / UK).
  String get displayCode => switch (this) {
    AppLocale.en => 'EN',
    AppLocale.uk => 'UK',
  };

  static AppLocale? tryParse(String? languageCode) {
    if (languageCode == null) return null;
    return AppLocale.values
        .where((locale) => locale.languageCode == languageCode)
        .firstOrNull;
  }
}
