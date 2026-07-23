import 'package:domain/models/enums/app_locale.dart';
import 'package:domain/repository/locale_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Locale;

class LocaleService extends ChangeNotifier {
  LocaleService(this._repository);

  final LocaleRepository _repository;

  AppLocale _locale = resolveDefaultLocale();

  AppLocale get locale => _locale;

  /// Ukraine → Ukrainian; everywhere else → English.
  static AppLocale resolveDefaultLocale([Locale? deviceLocale]) {
    final locale = deviceLocale ?? PlatformDispatcher.instance.locale;
    final isUkraine = locale.languageCode == 'uk' || locale.countryCode == 'UA';
    return isUkraine ? AppLocale.uk : AppLocale.en;
  }

  Future<void> load() async {
    final result = await _repository.getLocale();
    result.fold(
      onSuccess: (saved) {
        if (saved == null || _locale == saved) return;
        _locale = saved;
        notifyListeners();
      },
    );
  }

  Future<void> setLocale(AppLocale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    await _repository.saveLocale(locale);
  }
}
