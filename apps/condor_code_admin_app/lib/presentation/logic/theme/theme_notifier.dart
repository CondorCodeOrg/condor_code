import 'package:condorcode_admin/di/provider_manager.dart';
import 'package:domain/models/enums/theme_mode.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ui_kit/theme/theme_mode_service.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier({required ThemeModeService service})
    : _service = service,
      super(service.mode) {
    _service.addListener(_sync);
  }

  final ThemeModeService _service;

  void _sync() => state = _service.mode;

  Future<void> toggleTheme() => _service.toggle();

  @override
  void dispose() {
    _service.removeListener(_sync);
    super.dispose();
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((
  ref,
) {
  return ThemeNotifier(service: di<ThemeModeService>());
});
