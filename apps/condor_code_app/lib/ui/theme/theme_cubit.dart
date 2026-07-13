import 'package:domain/models/enums/theme_mode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/theme/theme_mode_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required ThemeModeService service})
    : _service = service,
      super(service.mode) {
    _service.addListener(_sync);
  }

  final ThemeModeService _service;

  void _sync() => emit(_service.mode);

  Future<void> toggleTheme() => _service.toggle();

  @override
  Future<void> close() {
    _service.removeListener(_sync);
    return super.close();
  }
}
