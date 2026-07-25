import 'package:condorcode_admin/di/provider_manager.dart';
import 'package:domain/models/enums/app_locale.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ui_kit/locale/locale_service.dart';

class LocaleNotifier extends StateNotifier<AppLocale> {
  LocaleNotifier({required LocaleService service})
    : _service = service,
      super(service.locale) {
    _service.addListener(_sync);
  }

  final LocaleService _service;

  void _sync() => state = _service.locale;

  Future<void> setLocale(AppLocale locale) => _service.setLocale(locale);

  @override
  void dispose() {
    _service.removeListener(_sync);
    super.dispose();
  }
}

final localeNotifierProvider = StateNotifierProvider<LocaleNotifier, AppLocale>(
  (ref) {
    return LocaleNotifier(service: di<LocaleService>());
  },
);
