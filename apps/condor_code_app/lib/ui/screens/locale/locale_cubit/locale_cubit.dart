import 'package:domain/models/enums/app_locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/locale/locale_service.dart';

class LocaleCubit extends Cubit<AppLocale> {
  LocaleCubit({required LocaleService service})
    : _service = service,
      super(service.locale) {
    _service.addListener(_sync);
  }

  final LocaleService _service;

  void _sync() => emit(_service.locale);

  Future<void> setLocale(AppLocale locale) => _service.setLocale(locale);

  @override
  Future<void> close() {
    _service.removeListener(_sync);
    return super.close();
  }
}
